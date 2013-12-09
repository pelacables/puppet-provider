Puppet::Type.type(:yumgroup).provide(:yumgroup) do
  desc "Support via `yum group{install.remove}`."

  commands :groupinstall    => "/usr/bin/yum"

        def create
                groupinstall("groupinstall", "-y", resource[:name])
        end
        def destroy
                groupinstall("groupremove", "-y", resource[:name])
        end
	def exists?
		isinstalled = false
		list_installed = false
		ENV['LANG'] = resource[:locale]
		execpipe "yum grouplist" do |grouplist|
			grouplist.collect do |group|
				#group.strip
				group.gsub!(/\n/,"")
				group.gsub!(/^\s+/,"")
				if group =~ /^Installed Groups/
					list_installed = true
				end
				if group =~ /^Available/
					list_installed = false
				end
				if (list_installed) 
					if group == resource[:name]
						isinstalled = true
					end 
				end
			end
		end
		isinstalled
	end
end
