/*:
 > **Start Up**
 > 1. Install Pod depencies by running `$ pod install`
 > 1. Open `ReactiveSwifty.xcworkspace`
 > 1. Build `ReactiveSwifty-iOS` scheme with an iOS Simulator
 > 1. Open the `Playground.playground`
 > 1. Run Playground !

 ***

 # ReactiveSwifty
 Enhances streams of values provided by ReactiveSwift

 ### Summary

 **Properties**
 - [`ActionProperty`](ActionProperty) : A read-only property with no default value
 - [`MutableActionProperty`](MutableActionProperty) : A mutable property with no default value

 **Property Operators**
 - [`ping()`](Ping) : Pings a MutableProperty
 - [`toggle()`](Toggle) : Toggles a MutableProperty of Bool
 - [`<> (swap)`](Swap) : Swaps a new value

 **Signal Operators**
 - [`combine(withLatest:)`](CombineWithLatest) : Combines value and latest value of another Signal
 - [`concatMap(with:)`](ConcatMap) : Maps to and concats Signals
 - [`filter(withLatest:isIncluded:), filter(withLatest:)`](FilterWithLatest) : Filters values with latest value of another Signal
 - [`mergeMap(with:)`](MergeMap) : Maps to and merges Signals
 - [`mapValue(:), mapVoid()`](Map) : Maps to a constant value
 - [`retry(every:on:)`](Retry) : Retries on failing, spacing out retries by a minimum interval
 - [`skipError()`](SkipError) : Skips error
 - [`spaceOut(by:on:)`](SpaceOut) : Spaces out values by a minimum interval time
 - [`switchMap(withLatest:)`](SwitchMap) : Maps to and switch to latest Signal

 **Materialized Signal Operators**
 - [`completes()`](Completes) : Pings on Complete Events
 - [`errors()`](Errors) : Maps error of Error Events
 - [`values()`](Values) : Maps value of Complete Events

 **Other**
 - [`Binding (<~)`](Binding) : Binds a Signal and an Observer
 - [`LifetimeProvider`](LifetimeProvider) : Observe object's deinitialization

 */
