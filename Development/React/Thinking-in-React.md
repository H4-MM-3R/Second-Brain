---
type: learn
file_t: database
name: react-basics
---

> [!NOTE] React Func: 
>  - Use the *User Interface* broken into pieces called **Components.**
>  - Describe visual *states* for each of the **Components.**
>  - *Connect* **Components** together so that the data flows through them.


### Start with the Mockup:
Lets say there is a JSON API and a mockup from a designer.

##### JSON: 

```json
[
  { category: "Fruits", price: "$1", stocked: true, name: "Apple" },
  { category: "Fruits", price: "$1", stocked: true, name: "Dragonfruit" },
  { category: "Fruits", price: "$2", stocked: false, name: "Passionfruit" },
  { category: "Vegetables", price: "$2", stocked: true, name: "Spinach" },
  { category: "Vegetables", price: "$4", stocked: false, name: "Pumpkin" },
  { category: "Vegetables", price: "$1", stocked: true, name: "Peas" }
]
```

##### Mockup:
![[Thinking-i-R-Mockup-drw|center|300]]
To Implementa UIin React, you will usually follow the same five steps.

## Step 1:  Break *UI* into **Component hierarchy**:

Depending on your background, you can try the following ways:

- **Programming**—if you should create a new function or object. One such technique is the [single responsibility principle](https://en.wikipedia.org/wiki/Single_responsibility_principle).
  
  that is, a component should ideally only do one thing. If it ends up growing, it should be decomposed into smaller subcomponents.
  
- **CSS**—consider what you would make class selectors for. (However, components are a bit less granular.)
- **Design**—consider how you would organize the design’s layers.

> [!NOTE] Note
> *UI* and *data* models often have the same information architecture,
> so, Separate your *UI* into **components,** where each component matches one piece of your **data model**.
![[Thinking-i-R-Components-drw|600|center]]
1. `FilterableProductTable` (white) contains the entire app.
2. `SearchBar` (lavender) receives the user input.
3. `ProductTable` (green) displays and filters the list according to the user input.
4. `ProductCategoryRow` (blue) displays a heading for each category.
5. `ProductRow` (orange) displays a row for each product.
#### Schema for above:
- `FilterableProductTable`
    - `SearchBar`
    - `ProductTable`
        - `ProductCategoryRow`
        - `ProductRow`

## Step 2:  Build a *static version* of **React**.
To build a static version of your app that renders your data model, 
you’ll want to build [components](https://react.dev/learn/your-first-component) that reuse other components and pass data using [Props.](https://react.dev/learn/passing-props-to-a-component).

> [!NOTE] Props
>  Props are a way of passing data from parent to child. 

(If you’re familiar with the concept of [State](https://react.dev/learn/state-a-components-memory), don’t use state at all to build this static version. 

**State** is reserved only for *interactivity,* that is, data that changes over time. Since this is a static version of the app, you don’t need it.)

```javascript
function ProductCategoryRow({ category }) {
  return (
    <tr>
      <th colSpan="2">
        {category}
      </th>
    </tr>
  );
}

function ProductRow({ product }) {
  const name = product.stocked ? product.name :
    <span style={{ color: 'red' }}>
      {product.name}
    </span>;

  return (
    <tr>
      <td>{name}</td>
      <td>{product.price}</td>
    </tr>
  );
}

function ProductTable({ products }) {
  const rows = [];
  let lastCategory = null;

  products.forEach((product) => {
    if (product.category !== lastCategory) {
      rows.push(
        <ProductCategoryRow
          category={product.category}
          key={product.category} />
      );
    }
    rows.push(
      <ProductRow
        product={product}
        key={product.name} />
    );
    lastCategory = product.category;
  });

  return (
    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Price</th>
        </tr>
      </thead>
      <tbody>{rows}</tbody>
    </table>
  );
}

function SearchBar() {
  return (
    <form>
      <input type="text" placeholder="Search..." />
      <label>
        <input type="checkbox" />
        {' '}
        Only show products in stock
      </label>
    </form>
  );
}

function FilterableProductTable({ products }) {
  return (
    <div>
      <SearchBar />
      <ProductTable products={products} />
    </div>
  );
}

const PRODUCTS = [
  {category: "Fruits", price: "$1", stocked: true, name: "Apple"},
  {category: "Fruits", price: "$1", stocked: true, name: "Dragonfruit"},
  {category: "Fruits", price: "$2", stocked: false, name: "Passionfruit"},
  {category: "Vegetables", price: "$2", stocked: true, name: "Spinach"},
  {category: "Vegetables", price: "$4", stocked: false, name: "Pumpkin"},
  {category: "Vegetables", price: "$1", stocked: true, name: "Peas"}
];

export default function App() {
  return <FilterableProductTable products={PRODUCTS} />;
}

```

> [!warning] Pitfall
> At this point, you should not be using any state values. That's for the next step!

## Step 3:  Find the *minimal* but complete representation of *UI* **state.**

The most important principle for structuring state is to keep it [DRY (Don’t Repeat Yourself).](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself)
###### Example:
if you’re building a shopping list, you can store the items as an array in state. 
If you want to also display the number of items in the list, 
don’t store the number of items as another state value—instead, read the length of your array.

Which of these are state? Identify the ones that are not:
- Does it **remain unchanged** over time? If so, it isn’t ~~state.~~
- Is it **passed in from a parent** via props? If so, it isn’t ~~state.~~
- **Can you compute it** based on existing state or props in your component? If so, it _definitely_ isn’t state!
What’s left is probably state.

1. The original list of products is **passed in as props, so it’s not state.**
2. The search text seems to be state since it changes over time and can’t be computed from anything.
3. The value of the checkbox seems to be state since it changes over time and can’t be computed from anything.
4. The filtered list of products **isn’t state because it can be computed** by taking the original list of products and filtering it according to the search text and value of the checkbox.

This means only the search text and the value of the checkbox are state!


> [!info] Deep Dive
> ### Props vs State:
> There are two types of “model” data in React: props and state. The two are very different:
> - [**Props** are like arguments you pass](https://react.dev/learn/passing-props-to-a-component) to a function. They let a parent component pass data to a child component and customize its appearance. For example, a `Form` can pass a `color` prop to a `Button`.
> - [**State** is like a component’s memory.](https://react.dev/learn/state-a-components-memory) It lets a component keep track of some information and change it in response to interactions. For example, a `Button` might keep track of `isHovered` state.

#### Props and state are different, but they work together. 
A **parent component** will often keep some information in **state** (so that it can change it), and _pass it down_ to **child components** as their props.

## Step 4:  Identify where your **state** should *live*:

> [!NOTE] 
> React uses *one-way data flow*, passind data down the component heirarchy.
For each piece of state in your application:

1. Identify _every_ component that renders something based on that state.
2. Find their **closest common parent component**—a *component* above them all in the hierarchy.
3. Decide where the state should live:
    - you can put the state directly into their common parent.
    - You can  put the state into some component above their **common parent**.
    -  If you can’t find a **component** where it makes sense to own the *state,* 
	    create a **new component** solely for holding the *state* and add it somewhere in the hierarchy above the **common parent component**.

For our Example:
1. **Identify components that use state:**
    - `ProductTable` needs to filter the product list based on that state (search text and checkbox value).
    - `SearchBar` needs to display that state (search text and checkbox value).
2. **Find their common parent:** The first parent component both components share is `FilterableProductTable`.
3. **Decide where the state lives**: We’ll keep the filter text and checked state values in `FilterableProductTable`.

So the state values will live in `FilterableProductTable`.

Add state to the component with the [`useState()` Hook.](https://react.dev/reference/react/useState) 


> [!info] Hook
> **Hooks** are special functions that let you “*hook into*” **React.**

 Add two **state** variables at the top of `FilterableProductTable` and specify their *initial state*:
```javascript
function FilterableProductTable({ products }) {  
const [filterText, setFilterText] = useState('');  
const [inStockOnly, setInStockOnly] = useState(false);
```

Then, pass `filterText` and `inStockOnly` to **ProductTable** and **SearchBar** as props:
```html
<div>
  <SearchBar 
    filterText={filterText} 
    inStockOnly={inStockOnly} />
  <ProductTable 
    products={products}
    filterText={filterText}
    inStockOnly={inStockOnly} />
</div>
```

Try changing the default value of `filterText` from useState('') to useState('fruit')
then,

> [!error] we will get an error
> value *prop* is provided to the *form field* without **onChange** handler.
> This will *render a read-only* field.

as we haven't added any code to **respond to the user actions** like typing yet.

## Step 5:  Add inverse data flow:
Currently your app renders correctly with **props** and **state** flowing *down the hierarchy*. 
But to change the **state** according to *user input*, you will need to **support data flowing the other way**: 

the form components deep in the hierarchy need to update the state in `FilterableProductTable`.

By writing `<input value={filterText} />`, 

you’ve set the `value` **prop** of the `input` to always be equal to the `filterText` **state** passed in from `FilterableProductTable`. 
Since `filterText` **state** is never set, the *input* never changes.

You want to make it so whenever the **user changes the form inputs**, the **state updates** to *reflect those* changes. 
The **state** is owned by `FilterableProductTable`,
so only it can call `setFilterText` and `setInStockOnly`.

To let `SearchBar` update the `FilterableProductTable`’s **state,** 
you need to pass these functions down to `SearchBar`:

```javascript
function FilterableProductTable({ products }) {  
const [filterText, setFilterText] = useState('');  
const [inStockOnly, setInStockOnly] = useState(false);  
return (  
<div>  
<SearchBar  
filterText={filterText}  
inStockOnly={inStockOnly}  
onFilterTextChange={setFilterText}  
onInStockOnlyChange={setInStockOnly} />
```

Inside the *SearchBar*, you will add the *onChange* **event handler** and set the parent state from them:

```javascript
<input  
type="text"  
value={filterText}  
placeholder="Search..."  
onChange={(e) => onFilterTextChange(e.target.value)} />
```
