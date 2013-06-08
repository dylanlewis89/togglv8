#! /usr/bin/env rvm ruby-1.9.3-head do ruby

require_relative 'togglV8'

tog = Toggl.new

# tog = Toggl.new(toggl_api_key)
# tog = Toggl.new(username, password)
# tog = Toggl.new('4p2hx5sfvb@snkmail.com') # ERROR

def print_projects(tog)
  ws = tog.workspaces
  ws.each do |w|
    wid = w['id']
    @wname=w['name']

    tp = Hash.new
    ts = tog.tasks(wid)
    ts.each do |t|
      tp[t['pid']] = t['name']
    end

    ps = tog.projects(wid)
    ps.each do |p|
      @pname = p['name'] + " [" + p['id'].to_s + "] "
      @tname = tp[p['id']] ? ' (' + tp[p['id']] + ')' : ''
      puts "#@wname - #@pname#@tname"
    end

    us = tog.users(wid)
    us.each do |u|
      @uname = u['fullname'] + "/" + u['email']
      puts "#@wname : #@uname"
    end
  end
end

#---- Workspaces ----#
# tk       : 282224  #
# HomeAway : 344974  #
#------- User -------#
# uid      : 360643  #
#--------------------#

if __FILE__ == $0
  tog.debugOn
  # ap tog.me
  # ap tog.me(true)
  # ap tog.me('false')
  # print_projects(tog)
  # ap tog.create_project({:name => "HUGE project", :wid => "282224"})
  # ap tog.create_task() # ERROR
  # ap tog.create_task({name: "TASK 1", pid: 2883126})
  # ap tog.create_task({name: "TASK 2", pid: 2883126})
  # ap tog.create_task({name: "TASK 3", pid: 2883126})
  # ap tog.update_task(1894758, {active: true, estimated_seconds: 45000, fields: "done_seconds,uname"})
  # ap tog.update_task(1894758, 1894732, {active: false})
  # ap tog.tasks(282224)
  # ap tog.tasks(282224, {active: :true})
  # ap tog.tasks(282224, {active: false})
  ap tog.tasks(282224, {active: 'both'})
  # ap tog.get_task(1894738)
  # ap tog.delete_task(1894728)
  ap tog.delete_task(1922691)
  ap tog.delete_task(1922690, 1922688)
  ap tog.tasks(282224, {active: 'both'})

end