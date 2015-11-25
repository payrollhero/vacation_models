class DailySchedule
  
  attr_accessor :status

  WORKING = :working
  NON_WORKING = :non_working

  WORKED = :worked
  VACATION = :vacation
  UNPAIDVACATION = :unpaid_vacation


  def initialize(status:)
    @status = status
  end

  def status=(next_status)
    unless self.status == NON_WORKING &&
      next_status == VACATION

      @status = next_status
    end
  end

end
