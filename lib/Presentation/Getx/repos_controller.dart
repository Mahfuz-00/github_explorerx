import 'package:get/get.dart';
import '../../Domain/Entities/repo.dart';
import '../../Domain/Usecases/fetch_repos.dart';

enum SortBy { nameAsc, nameDesc, dateNew, dateOld, stars }

class ReposController extends GetxController {
  final FetchRepos fetchRepos;
  ReposController(this.fetchRepos);

  // State
  final isLoading = true.obs;
  final error = RxnString();
  final _allRepos = <Repo>[].obs;
  final filtered = <Repo>[].obs;
  final isGrid = true.obs;
  final sortBy = SortBy.nameAsc.obs;
  final searchQuery = ''.obs;
  final isSearchExpanded = false.obs;

  @override
  void onInit() {
    super.onInit();
    ever(sortBy, (_) => _applyFilterAndSort());
    ever(searchQuery, (_) => _applyFilterAndSort());
  }

  Future<void> loadRepos(String username) async {
    isLoading(true);
    error(null);
    try {
      final result = await fetchRepos(username);
      result.fold(
            (failure) => error(failure.message),
            (data) {
          _allRepos.assignAll(data);
          _applyFilterAndSort();
        },
      );
    } finally {
      isLoading(false);
    }
  }

  void toggleView() => isGrid.toggle();

  void setSort(SortBy sort) => sortBy.value = sort;

  // void setSearch(String query) => searchQuery.value = query.trim().toLowerCase();

  void _applyFilterAndSort() {
    var list = List<Repo>.from(_allRepos);

    // === PREFIX SEARCH ONLY ===
    if (searchQuery.value.isNotEmpty) {
      final query = searchQuery.value;
      list = list.where((repo) {
        final name = repo.name.toLowerCase();
        return name.startsWith(query); // ← ONLY STARTS WITH
      }).toList();
    }

    // Sorting
    switch (sortBy.value) {
      case SortBy.nameAsc:
        list.sort((a, b) {
          final nameA = (a.name ?? '').trim().toLowerCase();
          final nameB = (b.name ?? '').trim().toLowerCase();
          return nameA.compareTo(nameB);
        });
        break;
      case SortBy.nameDesc:
        list.sort((a, b) {
          final nameA = (a.name ?? '').trim().toLowerCase();
          final nameB = (b.name ?? '').trim().toLowerCase();
          return nameB.compareTo(nameA);
        });
        break;
      case SortBy.dateNew:
        list.sort((a, b) => (b.updatedAt ?? b.createdAt).compareTo(a.updatedAt ?? a.createdAt));
        break;
      case SortBy.dateOld:
        list.sort((a, b) => (a.updatedAt ?? a.createdAt).compareTo(b.updatedAt ?? b.createdAt));
        break;
      case SortBy.stars:
        list.sort((a, b) => b.stargazersCount.compareTo(a.stargazersCount));
        break;
    }

    filtered.assignAll(list);
  }

  void setSearch(String query) {
    searchQuery.value = query.trim().toLowerCase();
    _applyFilterAndSort(); // ← THIS WAS MISSING
  }

  void clearSearch() {
    searchQuery.value = '';
    isSearchExpanded.value = false;
    _applyFilterAndSort(); // ← Also update when cleared
  }
}