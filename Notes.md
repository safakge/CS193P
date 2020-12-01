# CS193p Notes



## Lec 4
------

### ENUMS:
```
enum FastFoodMenuItem {
    case hamburger(numberOfPatties:Int) // ***numberOfPatties is an associated value
}
```
- enums can have methods, computed properties, **but NO stored properties**
- enum `TeslaModel:CaseIterable` *** gives you `TeslaModel.allCases()` which lets you iterate all cases

### OPTIONALS:

what it actually is:
```
enum Optional<T> {
    case none
    case some(T)
}
```



## Lec 5
------

### @ViewBuilder:

- `Group` is a `ViewBuilder`. `XStacks` are `ViewBuilders`

apply `@ViewBuilder` to a function or read-only computer var or a parameter that returns a View that return something that conforms to View. It will return by interpreting the contents as a list of Views and combine them into one. 
- That one View that it combines it into might be a TupleView (for 2 to 10 Views)
- Or it could be a _ConditionalContent View (if there's an if-else in the function)
- Or EmptyView (if there's nothing at all)
- OR any combination of the above



## Lec 6
------

### ANIMATION

Two types:
**-    Implicit Animation (declarative):**
by using the view modifier `.animation(Animation)`
`Text("asd")
.opacity(scary ? 1 : 0)
.animation(Animation.easeInOut)`
**(.animation modifier does not work like .padding, it just propagates to all Views it contains.)**
its argument is an `Animation` struct.

**-    Explicit Animation (imperative):**
by wrapping with 
    `withAnimation(Animation) { 
        // do something that will cause ViewModifier/Shape arguments to change somewhere
    }` around code that might change things. It will appear in closures like .onTapGesture.

Explicit anims are almost always wrapped around calls to *ViewModel Intent functions*. But they are also wrapped around things that only change the UI like "entering editing mode".

Explicit animations do not override an implicit animation.

**Transitions: How does a View arrives/departs the screen.**
    `RoundedRectangle().transition([.scale, .opacity, .identity ...])`
- They only work for Views that are in Containers that are already on-screen (ctaaos)
- Transitions do not work with impicit animations. Only explicit animations.
- They only activate when there's an explicit animation going on.
- Default .transition is `.opacity`
- `.transition(.identity)` = no transition animation
- *Unlike* implicit anims, transitions don't get propagated to all child Views.
- Transition API is *type erased* (`AnyTransition` struct:
    `AnyTransition.opacity
    AnyTransition.scale `<- uses .frame modifier to expand/shrink`
    AnyTransition.offset(CGSize) `use .offset modifier to move the View`
    AnyTransition.modifier(active:identity:)` <- you provide to ViewModifiers to use
)
you can also override the animation of an AnyTransition struct: .transition(.opacity.animation(.linear(duration: 20))) (**this is not an implicit animation!**)

-

All actual animation happens in Shapes and ViewModifiers. The animation system divides the anim duration up into little pieces. 
A Shape or ViewModifier lets the animation system know what information it wants piece-ified.
The animation system then tells the Shape/VM the current piece it should show.
Shapes/VMs that want to be animatable must implement `Animatable`. Which is a single var `animatableData: Type`










