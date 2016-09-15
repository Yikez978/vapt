module Methodologies

  def generate(helper, opts)
    @helper = helper
    @methodologies_overview_text = opts[:methodologies_overview]
    @information_gathering_text = opts[:information_gathering]
    @service_enumeration_text = opts[:service_enumeration]
    @enumerations = opts[:enumerations].values
    recipe
  end

  def recipe
    @helper.section(self, "Methodologies")
    move_down 20
    @helper.text(self, @methodologies_overview_text)

    @helper.subsection(self, 'Information Gathering')
    @helper.text(self, @information_gathering_text)

    @helper.subsection(self, 'Service Enumeration')
    @helper.text(self, @service_enumeration_text)
    move_down 20
    make_service_enumeration_table(@enumerations)
  end

  private

  def make_service_enumeration_table(enumerations)
    table = [['Server IP Address', 'Ports Open']]
    enumerations.each do |findings|
      table += [[findings[:server], "TCP: #{findings[:tcp]}\nUDP: #{findings[:udp]}"]]
    end

    table(table, header: true)
  end
end
