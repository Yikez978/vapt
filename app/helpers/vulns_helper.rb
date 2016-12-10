module VulnsHelper
  def vuln_label(num)
    case num
    when 0
      info
    when 1
      low
    when 2
      medium
    when 3
      high
    when 4
      critical
    end
  end

  def critical
    raw "<span class='vuln-label critical'>CRITICAL</span>"
  end

  def high
    raw "<span class='vuln-label high'>HIGH</span>"
  end

  def medium
    raw "<span class='vuln-label medium'>MEDIUM</span>"
  end

  def low
    raw "<span class='vuln-label low'>LOW</span>"
  end

  def info
    raw "<span class='vuln-label info'>INFO</span>"
  end
end
