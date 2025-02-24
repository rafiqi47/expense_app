# app/controllers/reports_controller.rb
require "csv"
require "prawn"

class ReportsController < ApplicationController
  def monthly_summary
    begin
      if params[:month].present?
        @month = Date.strptime(params[:month], "%Y-%m")
      else
        @month = Date.today.beginning_of_month
      end
    rescue ArgumentError
      flash[:alert] = "Invalid date format. Please use YYYY-MM."
      @month = Date.today.beginning_of_month
    end

    @summary = Expense.monthly_summary(@month)

    respond_to do |format|
      format.html
      format.csv do
        response.headers["Content-Disposition"] = "attachment; filename=monthly_summary.csv"
        render template: "reports/monthly_summary"
      end
      format.pdf do
        pdf_data = generate_pdf(@summary, @month)
        send_data pdf_data, filename: "monthly_summary.pdf", type: "application/pdf"
      end
    end
  end

  private

  def generate_pdf(summary, month)
    begin
      pdf = Prawn::Document.new

      pdf.text "Monthly Expense Summary - #{month.strftime('%B %Y')}", align: :center, size: 16
      pdf.move_down 20

      data = [ [ "Category", "Total Spending" ] ]
      summary.each { |category, total| data << [ category, total ] }
      data << [ "Total", summary.values.sum ]

      summary.each do |category, total|
        pdf.text "#{category} ------------ #{total}"
      end

      pdf.move_down 20
      pdf.text "Total ------------ #{summary.values.sum}"

      pdf.render
    rescue => e
      Rails.logger.error "Prawn Error: #{e.message}"
      "Error generating PDF: #{e.message}"
    end
  end
end
