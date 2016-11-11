# This is a mixin module to generate random id.
module RandomAlphaNumeric
  def generate_unique_id(field: :uid)
    return if send(field)
    loop do
      random_id = SecureRandom.uuid
      unless self.class.where(field => random_id).first
        break write_attribute(field, random_id)
      end
    end
  end
end