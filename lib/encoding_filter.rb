require 'iconv'
def utf8_to_gbk(str = '')
  Iconv.conv('gbk', 'utf-8', str)
end
def gbk_to_utf8(str = '')
  Iconv.conv('utf-8', 'gbk', str)
end
def u_to_g(str = '') utf8_to_gbk(str) end
def g_to_u(str = '') gbk_to_utf8(str) end

class String
  def u2g
    Iconv.conv('gbk', 'utf-8', self)
  end

  def g2u
    Iconv.conv('utf-8', 'gbk', self)
  end
end
