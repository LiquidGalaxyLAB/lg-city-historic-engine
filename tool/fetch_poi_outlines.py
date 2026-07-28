#!/usr/bin/env python3
"""Fetch OSM footprint polygons for Lleida POIs and emit Dart catalog."""
import json
import math
import time
import urllib.parse
import urllib.request

USER_AGENT = "lg-city-historic-engine/1.0 (outline-fetch)"
NOMINATIM = "https://nominatim.openstreetmap.org/search"
OVERPASS = "https://overpass-api.de/api/interpreter"

# canonical_name, lat, lng, search_queries (most specific first)
POIS = [
    ("Science Park", 41.605135, 0.607070, ["Parc Agrobiotech Lleida"]),
    ("Sícoris Club", 41.606622, 0.640498, ["Sícoris Club Lleida", "Club Sicoris Lleida"]),
    ("Camp d'Esports", 41.620982, 0.614260, ["Camp d'Esports Lleida", "Estadi Camp d'Esports"]),
    ("Castell Templer de Gardeny", 41.608256, 0.614865, ["Castell de Gardeny", "Castillo de Gardeny Lleida"]),
    ("Statue of Indíbil and Mandoni", 41.615162, 0.627375, ["Monument Indíbil Mandoni Lleida", "Plaça Agelet i Garriga Lleida"]),
    ("Old Hospital of Santa Maria", 41.612755, 0.623605, ["Antic Hospital de Santa Maria Lleida"]),
    ("La Paeria", 41.614591, 0.626919, ["Paeria Lleida", "Ajuntament de Lleida"]),
    ("Governor's Fountain", 41.617293, 0.628825, ["Font del Governador Lleida"]),
    ("Hospital Fountain", 41.612659, 0.623962, ["Font de l'Hospital Lleida"]),
    ("La Mitjana (natural heritage)", 41.626418, 0.648638, ["Parc de la Mitjana Lleida", "Espai Natural La Mitjana"]),
    ("General's Pillar", 41.615394, 0.627119, ["Pilar del General Lleida"]),
    ("La Suda of Lleida", 41.618660, 0.625649, ["Castell de la Suda Lleida", "Suda Lleida"]),
    ("Seu Vella", 41.617475, 0.626900, ["Seu Vella Lleida", "Catedral de Lleida"]),
    ("Sant Joan Square", 41.616028, 0.627358, ["Plaça de Sant Joan Lleida"]),
    ("Sant Anastasi Mill", 41.605572, 0.640122, ["Molí de Sant Anastasi Lleida"]),
    ("La Cuirassa", 41.614267, 0.625061, ["Call Jueu Lleida", "Cuirassa Lleida"]),
    ("Tanneries", 41.617285, 0.629640, ["Carrer de les Adoberies Lleida", "Adoberies Lleida"]),
    ("La Llotja", 41.619525, 0.637890, ["La Llotja Lleida", "Auditori Enric Granados Lleida"]),
    ("Europa Square", 41.625288, 0.622660, ["Plaça Europa Lleida"]),
    ("Lleida Courthouse", 41.616915, 0.626921, ["Palau de Justícia Lleida"]),
    ("Lleida–Pirineus Train Station", 41.620629, 0.632886, ["Estació de Lleida-Pirineus"]),
    ("Camps Elisis Park", 41.613817, 0.632234, ["Camps Elisis Lleida", "Parc dels Camps Elisis"]),
    ("Museum of Modern and Contemporary Art of Lleida", 41.617625, 0.629728, ["Museu Morera Lleida", "Museu d'Art Jaume Morera"]),
    ("Diocesan Museum", 41.613794, 0.620883, ["Museu de Lleida", "Museu Diocesà Lleida"]),
    ("Water Museum", 41.603211, 0.635728, ["Museu de l'Aigua Lleida", "Camp de la Canadenca Lleida"]),
    ("Automotive Museum", 41.613319, 0.632769, ["Museu de l'Automoció Lleida"]),
    ("Seu Vella Cathedral", 41.617475, 0.626900, ["Seu Vella Lleida"]),
    ("New Cathedral", 41.612900, 0.623125, ["Catedral Nova Lleida", "Nova Seu Lleida"]),
    ("Church of Sant Llorenç", 41.614250, 0.621639, ["Església de Sant Llorenç Lleida"]),
    ("Old Church of San Martí", 41.617669, 0.622039, ["Església de Sant Martí Lleida"]),
    ("Church of San Juan", 41.616403, 0.627722, ["Església de Sant Joan Lleida"]),
    ("Chapel of Sant Jaume", 41.613458, 0.624600, ["Capella de Sant Jaume Lleida"]),
    ("Chapel of la Sang", 41.611911, 0.621158, ["Oratori de la Sang Lleida"]),
    ("Church of Sant Pere", 41.614269, 0.626103, ["Església de Sant Pere Lleida"]),
    ("Hermitage of Granyena", 41.641917, 0.662147, ["Ermita de Granyena Alcoletge", "Ermita de la Mare de Déu de Granyena"]),
    ("Convent del Roser", 41.614419, 0.623989, ["Convent del Roser Lleida"]),
    ("Academia Mariana", 41.610928, 0.619022, ["Acadèmia Mariana Lleida", "Santuari de la Mare de Déu del Castell"]),
    # Historical events (pag_hechos_h.dart)
    ("Revolt of Indibilis and Mandonius", 41.6191230, 0.6232056, ["Seu Vella Lleida", "Centre històric Lleida"]),
    ("Battle of Ilerda, 49 BC", 41.6191230, 0.6232056, ["Seu Vella Lleida", "Pla d'Almatà Lleida"]),
    ("Muslim Invasion", 41.6180451, 0.6258326, ["Castell de la Suda Lleida", "Seu Vella Lleida"]),
    ("Siege of Lleida (800)", 41.6191230, 0.6232056, ["Seu Vella Lleida"]),
    ("Siege of Lleida (884)", 41.6191230, 0.6232056, ["Seu Vella Lleida"]),
    ("Christian Reconquest, 1149", 41.6089691, 0.6103237, ["Castell de Gardeny", "Castillo de Gardeny Lleida"]),
    ("Union of the Kingdom of Aragon and the County of Barcelona", 41.6167910, 0.6254991, ["Seu Vella Lleida", "Plaça de la Catedral Lleida"]),
    ("Oath of Allegiance to James I", 41.6180451, 0.6258326, ["Castell de la Suda Lleida"]),
    ("First University of the Kingdom of Aragon", 41.6146803, 0.6198760, ["Estudi General Lleida", "Universitat de Lleida històric"]),
    ("Siege of Lleida (1413)", 41.6191230, 0.6232056, ["Seu Vella Lleida"]),
    ("The Battle of Lleida (1642)", 41.6100091, 0.6367412, ["Camps Elisis Lleida"]),
    ("Siege of Lleida (1644)", 41.6149206, 0.6204228, ["Seu Vella Lleida", "Catedral de Lleida"]),
    ("Siege of Lleida (1646)", 41.6191230, 0.6232056, ["Seu Vella Lleida"]),
    ("Siege of Lleida (1647)", 41.6191230, 0.6232056, ["Seu Vella Lleida"]),
    ("Siege of Lleida (1707)", 41.6191230, 0.6232056, ["Seu Vella Lleida"]),
    ("Siege of Lleida (1810)", 41.6191230, 0.6232056, ["Seu Vella Lleida"]),
    ("Battle of Lleida (1938)", 41.6191230, 0.6232056, ["Seu Vella Lleida", "Centre històric Lleida"]),
]


def http_get(url, data=None):
    req = urllib.request.Request(
        url,
        data=data,
        headers={"User-Agent": USER_AGENT},
        method="POST" if data else "GET",
    )
    with urllib.request.urlopen(req, timeout=60) as resp:
        return resp.read().decode("utf-8")


def dist_m(lat1, lng1, lat2, lng2):
    r = 6378137.0
    dlat = math.radians(lat2 - lat1)
    dlng = math.radians(lng2 - lng1)
    a = math.sin(dlat / 2) ** 2 + math.cos(math.radians(lat1)) * math.cos(math.radians(lat2)) * math.sin(dlng / 2) ** 2
    return 2 * r * math.asin(math.sqrt(a))


def ring_from_geojson(geo):
    t = geo.get("type")
    coords = geo.get("coordinates")
    if t == "Polygon":
        ring = coords[0]
    elif t == "MultiPolygon":
        ring = max(coords, key=lambda p: len(p[0]))[0]
    else:
        return None
    return [(p[0], p[1]) for p in ring]


def point_in_ring(lng, lat, ring):
    inside = False
    n = len(ring)
    for i in range(n):
        x1, y1 = ring[i]
        x2, y2 = ring[(i + 1) % n]
        if ((y1 > lat) != (y2 > lat)) and (lng < (x2 - x1) * (lat - y1) / (y2 - y1 + 1e-12) + x1):
            inside = not inside
    return inside


def simplify_ring(ring, max_points=24):
    if len(ring) <= max_points:
        return ring
    step = max(1, len(ring) // max_points)
    simplified = ring[::step]
    if simplified[0] != simplified[-1]:
        simplified.append(simplified[0])
    return simplified


def nominatim_polygon(query, lat, lng):
    params = urllib.parse.urlencode(
        {
            "q": f"{query}, Lleida, Spain",
            "format": "json",
            "polygon_geojson": "1",
            "limit": "5",
        }
    )
    raw = http_get(f"{NOMINATIM}?{params}")
    results = json.loads(raw)
    best = None
    best_score = float("inf")
    for item in results:
        geo = item.get("geojson")
        if not geo:
            continue
        ring = ring_from_geojson(geo)
        if not ring or len(ring) < 4:
            continue
        ilat = float(item["lat"])
        ilng = float(item["lon"])
        d = dist_m(lat, lng, ilat, ilng)
        contains = point_in_ring(lng, lat, ring)
        score = d if contains else d + 500
        if score < best_score:
            best_score = score
            best = ring
    return best


def overpass_building(lat, lng, radius=90):
    q = f"""
    [out:json][timeout:25];
    (
      way(around:{radius},{lat},{lng})["building"];
      relation(around:{radius},{lat},{lng})["building"];
      way(around:{radius},{lat},{lng})["landuse"];
      way(around:{radius},{lat},{lng})["leisure"];
    );
    out geom;
    """
    raw = http_get(OVERPASS, data=f"data={urllib.parse.quote(q)}".encode())
    data = json.loads(raw)
    best = None
    best_area = 0
    for el in data.get("elements", []):
        ring = None
        if el["type"] == "way" and "geometry" in el:
            ring = [(p["lon"], p["lat"]) for p in el["geometry"]]
        elif el["type"] == "relation" and "members" in el:
            outer = [m for m in el["members"] if m.get("role") == "outer" and "geometry" in m]
            if outer:
                ring = [(p["lon"], p["lat"]) for p in outer[0]["geometry"]]
        if not ring or len(ring) < 4:
            continue
        if not point_in_ring(lng, lat, ring):
            # accept nearest if within 60m of POI
            cx = sum(p[0] for p in ring) / len(ring)
            cy = sum(p[1] for p in ring) / len(ring)
            if dist_m(lat, lng, cy, cx) > 60:
                continue
        xs = [p[0] for p in ring]
        ys = [p[1] for p in ring]
        area = (max(xs) - min(xs)) * (max(ys) - min(ys))
        if area > best_area:
            best_area = area
            best = ring
    return best


def oriented_rect(lat, lng, range_m, heading):
    half_l = max(25, min(range_m * 0.38, 140))
    half_w = half_l * 0.72
    heading_rad = math.radians((heading or 0) - 90)
    corners = [
        (half_l, -half_w),
        (half_l, half_w),
        (-half_l, half_w),
        (-half_l, -half_w),
    ]
    ring = []
    for north, east in corners:
        rn = north * math.cos(heading_rad) - east * math.sin(heading_rad)
        re = north * math.sin(heading_rad) + east * math.cos(heading_rad)
        dlat = rn / 6378137.0 * 180 / math.pi
        dlng = re / (6378137.0 * math.cos(math.radians(lat))) * 180 / math.pi
        ring.append((lng + dlng, lat + dlat))
    ring.append(ring[0])
    return ring


def fetch_ring(name, lat, lng, queries):
    for q in queries:
        ring = nominatim_polygon(q, lat, lng)
        if ring:
            return ring, f"nominatim:{q}"
        time.sleep(1.1)
    ring = overpass_building(lat, lng)
    if ring:
        return ring, "overpass:building"
    return oriented_rect(lat, lng, 120, 0), "fallback:rect"


def dart_ring(name, ring):
    lines = []
    for lng, lat in ring:
        lines.append(f"      [{lng:.7f}, {lat:.7f}],")
    return lines


def main():
    entries = {}
    meta = {}
    for name, lat, lng, queries in POIS:
        if name in entries:
            continue
        print(f"Fetching {name}...")
        ring, source = fetch_ring(name, lat, lng, queries)
        ring = simplify_ring(ring)
        if ring[0] != ring[-1]:
            ring.append(ring[0])
        entries[name] = ring
        meta[name] = source
        time.sleep(1.1)

    print("\n// Sources:", json.dumps(meta, indent=2))
    print("\nstatic const Map<String, List<List<double>>> _byCanonicalName = {")
    for name, ring in entries.items():
        safe = name.replace("'", "\\'")
        print(f"    '{safe}': [")
        for line in dart_ring(name, ring):
            print(line)
        print("    ],")
    print("};")


if __name__ == "__main__":
    main()
