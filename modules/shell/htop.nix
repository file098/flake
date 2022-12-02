{ ... }:

{
  programs.htop = {
    enable = true;
    settings = {
      all_branches_collapsed = 0;
      color_scheme = 6;
      cpu_count_from_one = 0;
      delay = 15;
      show_cpu_frequency = 1;
      show_cpu_temperature = 1;
      sort_direction = -1;
      sort_key = 46;
      tree_sort_direction = 1;
      tree_sort_key = 0;
      tree_view_always_by_pid = 0;
      tree_view = 0;
    };
  };
}
