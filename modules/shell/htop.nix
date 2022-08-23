{...}:

{
  programs.htop = {
    enable = true;
    settings = {
      tree_view=0
      sort_key=46
      tree_sort_key=0
      sort_direction=-1
      tree_sort_direction=1
      tree_view_always_by_pid=0
      all_branches_collapsed=0
      screen:Main=PID USER PRIORITY NICE M_VIRT M_RESIDENT M_SHARE STATE PERCENT_CPU PERCENT_MEM TIME Co    mmand
      .sort_key=PERCENT_CPU
      .tree_sort_key=PID
      .tree_view=0
      .tree_view_always_by_pid=0
      .sort_direction=-1
      .tree_sort_direction=1
      .all_branches_collapsed=0
      screen:I/O=PID USER IO_PRIORITY IO_RATE IO_READ_RATE IO_WRITE_RATE
      .sort_key=IO_RATE
      .tree_sort_key=PID
      .tree_view=0
      .tree_view_always_by_pid=0
      .sort_direction=-1
      .tree_sort_direction=1
      .all_branches_collapsed=0px
    };
  };
}