class BlogPostImporter
  @@subclasses = { }
  def self.create type
    c = @@subclasses[type]
    if c
      c.new
    else
      raise "Bad importer type: #{type}"
    end
  end
  def self.register_importer name
    @@subclasses[name] = self
  end
end

def BlogPostImporter name, superclass=BlogPostImporter, &block
  Class.new(superclass, &block).register_importer(name)
end