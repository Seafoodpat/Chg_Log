json.array!(@logs) do |log|
  json.extract! log, :id, :chq_number, :chq_date, :payee_name, :category, :deal_id, :particular, :currencies, :amount, :prepared, :sign_date, :present_date, :status, :void_reason
  json.url log_url(log, format: :json)
end
