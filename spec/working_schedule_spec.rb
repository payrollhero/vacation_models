require 'spec_helper'

describe WorkingSchedule do

  describe 'one working day' do
    example do
      daily_schedules = [
        DailySchedule.new(status: DailySchedule::WORKING)
      ]

      ws = WorkingSchedule.new(leave_balance: 1, daily_schedules: daily_schedules)
      ws.work(daily_schedules)

      expect(ws.total_worked_days).to eq 1
      expect(ws.total_paid_days).to eq 1
    end
  end

  describe 'one working and one vacation day' do
    example do
      daily_schedules = [
        DailySchedule.new(status: DailySchedule::WORKING),
        DailySchedule.new(status: DailySchedule::VACATION)
      ]

      ws = WorkingSchedule.new(leave_balance: 1, daily_schedules: daily_schedules)
      ws.work([daily_schedules[0]])

      expect(ws.total_worked_days).to eq 1
      expect(ws.total_paid_days).to eq 2
    end
  end

  describe 'with nonworking days' do
    let(:first_day) { DailySchedule.new(status: DailySchedule::NON_WORKING) }
    let(:second_day) { DailySchedule.new(status: DailySchedule::NON_WORKING) }
    let(:daily_schedules) { [first_day, second_day] }
    let(:ws) { WorkingSchedule.new(leave_balance: 1, daily_schedules: daily_schedules) }

    context 'set as vacation days' do
      example do
        first_day.status = DailySchedule::VACATION
        second_day.status = DailySchedule::VACATION

        expect(ws.total_worked_days).to eq 0
        expect(ws.total_paid_days).to eq 0
      end
    end

    context 'set as working and vacation days respectively' do
      example do
        first_day.status = DailySchedule::WORKING
        second_day.status = DailySchedule::VACATION

        ws.work([first_day])

        expect(ws.total_worked_days).to eq 1
        expect(ws.total_paid_days).to eq 1
      end
    end
  end

  describe 'multiple vacation days' do
    let(:first) { DailySchedule.new(status: DailySchedule::WORKING) }
    let(:second) { DailySchedule.new(status: DailySchedule::VACATION) }
    let(:third) { DailySchedule.new(status: DailySchedule::VACATION) }
    let(:fourth) { DailySchedule.new(status: DailySchedule::VACATION) }
    let(:fifth) { DailySchedule.new(status: DailySchedule::VACATION) }
    let(:daily_schedules) {
      [first, second, third, fourth, fifth]
    }
    let(:ws) { WorkingSchedule.new(leave_balance: 1, daily_schedules: daily_schedules) }

    context 'and some are worked' do
      example do
        ws.work([first, fourth])
        expect(ws.total_worked_days).to eq 2
        expect(ws.total_paid_days).to eq 5
      end
    end
  end
end
