import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Presentation/Getx/repos_controller.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ReposController>();
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.18), blurRadius: 20, spreadRadius: 2, offset: const Offset(0, 8)),
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          // === SEARCH: SQUARE ICON → EXPANDS TO BAR ===
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Obx(() {
                  final isExpanded = ctrl.isSearchExpanded.value;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: isExpanded ? constraints.maxWidth : 40,
                    height: 40,
                    child: OverflowBox(
                      maxWidth: constraints.maxWidth,
                      child: isExpanded
                          ? _buildSearchBar(ctrl, theme)
                          : _buildSearchIcon(ctrl, theme),
                    ),
                  );
                });
              },
            ),
          ),
          SizedBox(width: 8,),

          // === DROPDOWN: HIDE FIRST → FADE IN LATER ===
          Obx(() {
            final isExpanded = ctrl.isSearchExpanded.value;
            return AnimatedOpacity(
              opacity: isExpanded ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 150),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isExpanded ? 0 : 140,
                height: 40,
                curve: Curves.easeInOut,
                child: isExpanded ? const SizedBox() : _buildSortDropdown(ctrl, theme),
              ),
            );
          }),

          const SizedBox(width: 8), // TIGHT SPACE

          // === GRID/LIST TOGGLE: SQUARE ===
          SizedBox(
            height: 40,
            width: 40,
            child: _buildViewToggle(ctrl, theme),
          ),
        ],
      ),
    );
  }

  // SQUARE SEARCH ICON
  Widget _buildSearchIcon(ReposController ctrl, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(Icons.search, size: 20, color: theme.colorScheme.primary),
        onPressed: () {
          ctrl.isSearchExpanded.value = true;
        },
      ),
    );
  }

  // EXPANDED SEARCH BAR
  Widget _buildSearchBar(ReposController ctrl, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          const Icon(Icons.search, size: 18),
          const SizedBox(width: 6),
          Expanded(
            child: TextField(
              autofocus: true,
              onChanged: ctrl.setSearch,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(fontSize: 14),
            ),
          ),
          // ALWAYS SHOW X WHEN EXPANDED
          GestureDetector(
            onTap: () {
              ctrl.clearSearch();
              ctrl.isSearchExpanded.value = false;
            },
            child: const Icon(Icons.close, size: 16),
          ),
        ],
      ),
    );
  }


// === DROPDOWN ===
  Widget _buildSortDropdown(ReposController ctrl, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant.withOpacity(0.6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.colorScheme.outline.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Obx(() {
        final current = ctrl.sortBy.value;

        return DropdownButtonHideUnderline(
          child: DropdownButton<SortBy>(
            value: current,
            icon: Icon(Icons.keyboard_arrow_down, size: 18, color: theme.colorScheme.primary),
            dropdownColor: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
            elevation: 3,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            isDense: true,
            items: SortBy.values.map((sort) {
              return DropdownMenuItem<SortBy>(
                value: sort,
                child: Row(
                  children: [
                    _sortIcon(sort, theme),
                    const SizedBox(width: 4),
                    Text(
                      _sortLabel(sort),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (SortBy? value) {
              if (value != null) {
                ctrl.setSort(value); // Triggers sort + UI update
              }
            },
          ),
        );
      }),
    );
  }

  // TOGGLE
  Widget _buildViewToggle(ReposController ctrl, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Obx(() {
        final isGrid = ctrl.isGrid.value;
        return IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            isGrid ? Icons.format_list_bulleted : Icons.grid_view,
            size: 20,
            color: theme.colorScheme.primary,
          ),
          onPressed: ctrl.toggleView,
        );
      }),
    );
  }

  Icon _sortIcon(SortBy sort, ThemeData theme) {
    final color = theme.colorScheme.primary;
    return switch (sort) {
      SortBy.nameAsc || SortBy.nameDesc => Icon(Icons.sort_by_alpha, size: 14, color: color),
      SortBy.dateNew || SortBy.dateOld => Icon(Icons.access_time, size: 14, color: color),
      SortBy.stars => Icon(Icons.star, size: 14, color: color),
    };
  }

  String _sortLabel(SortBy sort) {
    return switch (sort) {
      SortBy.nameAsc => 'A-Z',
      SortBy.nameDesc => 'Z-A',
      SortBy.dateNew => 'Newest',
      SortBy.dateOld => 'Oldest',
      SortBy.stars => 'Stars',
    };
  }
}