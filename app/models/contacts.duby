import com.google.appengine.ext.duby.db.Model
import com.google.appengine.api.datastore.*
import java.util.HashMap
import dubious.Params

class Contact < Model
  def initialize; end

  property 'title',   String
  property 'summary', Text
  property 'url',     Link
  property 'address', PostalAddress
  property 'phone',   PhoneNumber

  def attributes      # empty strings best
    hm = HashMap.new  # for form population
    hm.put("title",   @title   || "")
    hm.put("summary", @summary || "")
    hm.put("url",     @url     || "")
    hm.put("address", @address || "")
    hm.put("phone",   @phone   || "")
    hm.put("kind", 'contact') # reserved?
    hm 
  end

  def update_attributes(params:Params)
    returns void
    request = params.request
    self.title   = request.getParameter('contact[title]')   || ""
    self.summary = request.getParameter('contact[summary]') || ""
    self.url     = request.getParameter('contact[url]')     || ""
    self.address = request.getParameter('contact[address]') || ""
    self.phone   = request.getParameter('contact[phone]')   || ""
    self.url     = nil if self.url.equals("")
    self.address = nil if self.address.equals("")
    self.phone   = nil if self.phone.equals("")
    self.save
  end
end