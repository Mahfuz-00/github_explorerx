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

    // Search filter
    if (searchQuery.value.isNotEmpty) {
      list = list
          .where((repo) => repo.name.toLowerCase().contains(searchQuery.value))
          .toList();
    }

    // Sorting
    switch (sortBy.value) {
      case SortBy.nameAsc:
        list.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortBy.nameDesc:
        list.sort((a, b) => b.name.compareTo(a.name));
        break;
      case SortBy.dateNew:
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case SortBy.dateOld:
        list.sort((a, b) => a.createdAt.compareTo(a.createdAt));
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