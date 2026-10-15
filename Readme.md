# ClassyCal project

## Features
- iOS app to add, track, manage college subjects, schedule

## Timeline v0.1
- Day1: plan, set repo, basic tabs working, add subjects, semesters, test passed - done
- Day2: Subject Detail, Edit & Delete (in progress)
-Day 2.1: deep testing
- Day3: signatures, license, submit App store

## Planning
The import Testing issue is resolved and the persistence test passing, I can keep Swift Testing for unit tests and use XCUITest for UI automation later.
Today I'm turning the Subjects screen into a complete feature, not just a list with an Add button.
Today's goals
- Navigate from a subject row to its detail screen.
- Display course information and its associated semester.
- Edit a subject using a reusable form.
- Delete a subject with confirmation.
- Test update and delete operations.
- Keep everything synchronized automatically through SwiftData.
I'll also introduce one important architectural improvement: a reusable subject form, so Add and Edit don't duplicate UI code.
1. The screen flow
(see diagram)
## Architecture decisions for Day 2
```swift
I'll keep using @Query for the list, @Bindable for editing observable model properties when appropriate, and @Environment(\.modelContext) for persistence.
```
```swift
For the edit form, though, we'll use draft state (@State) instead of binding text fields directly to the persisted model. This prevents pressing Cancel from leaving partially edited values in SwiftData.
```
No ViewModel is needed yet.
Todo: create 2 new files: SUbjectDetailView, SubjectFormView (reusable) form view
One simplification above: subject.semester! assumes every subject belongs to a semester. That is consistent with our intended app rules, but the Day 1 model allows a nil relationship.
Before shipping, we'll enforce that invariant consistently. For now, only edit subjects created through the normal app flow, which assigns a semester.

## Day 3

## Copyright
2026 West AI Engineering - All Rights Reserved
