import 'package:flutter/material.dart';
import '../main.dart';
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

/// Desplegable de categorías con área táctil amplia.
class CategoryFilterDropdown extends StatelessWidget {
  const CategoryFilterDropdown({
    super.key,
    required this.selectedCategory,
    required this.categories,
    required this.onSelected,
    required this.labelForCategory,
  });

  final String selectedCategory;
  final List<String> categories;
  final ValueChanged<String> onSelected;
  final String Function(String category) labelForCategory;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      offset: const Offset(0, 68),
      padding: EdgeInsets.zero,
      splashRadius: 28,
      tooltip: '',
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 12,
      itemBuilder: (context) => categories
          .map(
            (cat) => PopupMenuItem<String>(
              value: cat,
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                labelForCategory(cat),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: selectedCategory == cat
                      ? FontWeight.w800
                      : FontWeight.w500,
                  color: context.appOnSurface,
                ),
              ),
            ),
          )
          .toList(),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppTheme.chipBackground(context),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              T.s('categories'),
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 15,
                color: context.appOnSurface,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(width: 6),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: context.appOnSurface,
              size: 22,
            ),
          ],
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
      height: 68,
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
          const SizedBox(width: 16),
          Icon(Icons.search_rounded,
              color: context.appOnSurfaceVariant, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: onSearchChanged,
              style: TextStyle(fontSize: 17, color: context.appOnSurface),
              decoration: InputDecoration(
                hintText: searchHint,
                hintStyle: TextStyle(
                  color: context.appOnSurfaceVariant,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.2,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          if (searchQuery.isNotEmpty)
            IconButton(
              onPressed: onClearSearch,
              icon: Icon(Icons.close_rounded,
                  color: context.appOnSurfaceVariant, size: 22),
              iconSize: 22,
              padding: const EdgeInsets.all(12),
              constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
              splashRadius: 24,
            ),
          const SizedBox(width: 4),
          SizedBox(height: 48, child: categoryMenu),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
