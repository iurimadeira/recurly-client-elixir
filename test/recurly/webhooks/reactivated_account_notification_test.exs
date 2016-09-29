defmodule Recurly.Webhooks.ReactivatedAccountNotificationTest do
  use ExUnit.Case, async: true
  alias Recurly.{Webhooks,Account,Subscription}

  test "correctly parses payload" do
    xml_doc = """
      <reactivated_account_notification>
        <account>
          <account_code>1</account_code>
          <username nil="true"></username>
          <email>verena@example.com</email>
          <first_name>Verena</first_name>
          <last_name>Example</last_name>
          <company_name nil="true"></company_name>
        </account>
        <subscription>
          <plan>
            <plan_code>bootstrap</plan_code>
            <name>Bootstrap</name>
          </plan>
          <uuid>6ab458a887d38070807ebb3bed7ac1e5</uuid>
          <state>active</state>
          <quantity type="integer">1</quantity>
          <total_amount_in_cents type="integer">9900</total_amount_in_cents>
          <subscription_add_ons type="array"/>
          <activated_at type="datetime">2010-07-22T20:42:05Z</activated_at>
          <canceled_at nil="true" type="datetime"></canceled_at>
          <expires_at nil="true" type="datetime"></expires_at>
          <current_period_started_at type="datetime">2010-09-22T20:42:05Z</current_period_started_at>
          <current_period_ends_at type="datetime">2010-10-22T20:42:05Z</current_period_ends_at>
          <trial_started_at nil="true" type="datetime"></trial_started_at>
          <trial_ends_at nil="true" type="datetime"></trial_ends_at>
          <collection_method>automatic</collection_method>
        </subscription>
      </reactivated_account_notification>
    """

    notification = %Webhooks.ReactivatedAccountNotification{} = Webhooks.parse(xml_doc)
    account = %Account{} = notification.account
    subscription = %Subscription{} = notification.subscription

    assert account.account_code == "1"
    assert subscription.uuid == "6ab458a887d38070807ebb3bed7ac1e5"
  end
end