require 'pg'

class Connection

  def self.db
    @db ||= PG::Connection.new({
      host: 'ec2-107-22-187-89.compute-1.amazonaws.com',
      user: 'ifduxfxmzrcmeh',
      password: 'oXFX1ZqyMmcNR64FLLjE0AkqBI',
      dbname: 'd85rev9pvip07q'
    })
  end

end