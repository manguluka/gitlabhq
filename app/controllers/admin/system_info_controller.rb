class Admin::SystemInfoController < Admin::ApplicationController
  def show
    system_info = Vmstat.snapshot
    @load = system_info.load_average.collect { |v| v.round(2) }.join(', ')

    @mem_used = system_info.memory.active_bytes
    @mem_total = system_info.memory.total_bytes

    @disk_used = system_info.disks[0].used_bytes
    @disk_total = system_info.disks[0].total_bytes
  end
end
