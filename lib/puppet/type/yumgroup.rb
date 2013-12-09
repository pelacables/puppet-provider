Puppet::Type.newtype(:yumgroup) do
  @doc='Type for defining yum groups'

	ensurable
	newparam(:name) do
		isnamevar
	end
	newparam(:locale) do
		desc 'Language used for listing groups'
		defaultto "C"
	end

end
