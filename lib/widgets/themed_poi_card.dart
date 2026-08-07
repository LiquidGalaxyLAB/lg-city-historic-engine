import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Tarjeta de listado de POI / museos / eventos con colores según el tema.
class ThemedPoiCard extends StatelessWidget {
  const ThemedPoiCard({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.actionLabel,
    required this.onSend,
  });

  final String imageAsset;
  final String title;
  final String actionLabel;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onSend,
        borderRadius: BorderRadius.circular(24),
        child: Container(
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            color: context.appSurface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withValues(alpha: AppTheme.shadowAlpha(context)),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(24)),
                child: Image.asset(
                  imageAsset,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      color: context.isDarkMode
                          ? const Color(0xFF3A342C)
                          : Colors.grey[300],
                      child: Icon(
                        Icons.image_not_supported,
                        size: 50,
                        color: context.appOnSurfaceVariant,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'serif',
                        color: context.appOnSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Divider(
                      color: Theme.of(context).dividerColor,
                      thickness: 1.5,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.chipBackground(context)
                                .withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Text(
                                actionLabel,
                                style: const TextStyle(
                                  color: Color(0xFF6B5B45),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 13,
                                  letterSpacing: 0.6,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                size: 16,
                                color: Color(0xFF6B5B45),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Barra de búsqueda y filtro para listados.
class ThemedListFilterBar extends StatelessWidget {
  const ThemedListFilterBar({
    super.key,
    required this.searchController,
    required this.searchHint,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.onClearSearch,
    required this.categoryMenu,
  });

  final TextEditingController searchController;
  final String searchHint;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClearSearch;
  final Widget categoryMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withValues(alpha: AppTheme.shadowAlpha(context)),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 18),
          Icon(Icons.search_rounded,
              color: context.appOnSurfaceVariant, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: onSearchChanged,
              style: TextStyle(fontSize: 16, color: context.appOnSurface),
              decoration: InputDecoration(
                hintText: searchHint,
                hintStyle: TextStyle(
                  color: context.appOnSurfaceVariant,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.2,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (searchQuery.isNotEmpty)
            GestureDetector(
              onTap: onClearSearch,
              child: Icon(Icons.close_rounded,
                  color: context.appOnSurfaceVariant, size: 20),
            ),
          const SizedBox(width: 10),
          categoryMenu,
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
