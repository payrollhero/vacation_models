require 'spec_helper'

describe DailySchedule do

  let(:non_working) { DailySchedule::NON_WORKING }
  let(:vacation) { DailySchedule::VACATION }
  let(:working) { DailySchedule::WORKING }

  describe 'when updating daily schedule' do
    it 'should update status from working to vacation' do
      schedule = DailySchedule.new(status: working)
      schedule.status = vacation
      expect(schedule.status).to eq(vacation)
    end

    it 'should not change status from nonworking to vacation' do
      schedule = DailySchedule.new(status: non_working)
      schedule.status = vacation
      expect(schedule.status).to eq(non_working)
    end
  end
end
