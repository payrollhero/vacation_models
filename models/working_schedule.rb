class WorkingSchedule

  attr_accessor :leave_balance, :daily_schedules

  def initialize(leave_balance:, daily_schedules: [])
    @leave_balance = leave_balance
    @daily_schedules = daily_schedules
  end

  def work(daily_schedules)
    daily_schedules.each do |daily_schedule|
      daily_schedule.status = DailySchedule::WORKED
    end
  end

  def total_paid_days
    total_worked_days + total_vacation_days
  end

  def total_worked_days
    daily_schedule_count_for(status: DailySchedule::WORKED)
  end

  def total_vacation_days
    daily_schedule_count_for(status: DailySchedule::VACATION)
  end

  private

  def daily_schedule_count_for(status:)
    daily_schedules.count { |ds| ds.status == status }
  end

end
