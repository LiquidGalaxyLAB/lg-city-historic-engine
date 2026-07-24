/// Escapa texto para nodos XML en KML.
String escapeXml(String value) {
  return value
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;')
      .replaceAll('"', '&quot;')
      .replaceAll("'", '&apos;');
}

/// Escapa texto dentro de HTML embebido en CDATA (atributos y nodos).
String escapeHtml(String value) => escapeXml(value);

/// Evita romper bloques CDATA en KML.
String sanitizeCData(String value) =>
    value.replaceAll(']]>', ']]]]><![CDATA[>');
