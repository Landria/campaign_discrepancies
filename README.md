# Campaign Discrepancies

This is an https://github.com/heyjobs/ruby-task task solution

Ruby 2.5.0

## Campaign discrepancy service

This is service for checking for syncronization issues for a **Campaign** model.

It retrieves remote ads data and compare it with local.

## Usage

Add **campaign_discrepancy** lib into Ruby on Rails app services and use wherever you want just calling

```
CampaignDiscrepancy::Checker.run.state
```

**CampaignDiscrepancy::Checker** servise has attributes:

* *state* - where all found discrepancies stored
* *errors* - array with errors ocurred if any
* *external_ads* - array with remote ads parsed data


To know if service performed succesfully run

```
checker = CampaignDiscrepancy::Checker.run
checker.state
```

## Solution notes

Solusion is assumed to be a part od Ruby on Rails appliation.

To test it localy **Campaign** model is stubbed with support class and object_double and Rails app Settings stubbed with **Settings** class.

Solution can be easily changed to check more attributes if needed with just adding new items to **CampaignDiscrepancy::Checker** METRICS constant.

Custom errors can be defined for the service. **Errors::ExternalAdsFetchError** error added to collect all fetch remote data issues.
