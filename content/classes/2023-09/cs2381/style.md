---
title: "CS2381: Java Style Rules"
date: "2023-07-08"
---


## Javadoc

Javadoc is a set of conventions for using comments to 

### Examples

Record example:

```java
/**
	A field for planting corn. We only handle rectangular fields.
	
	@author Nat Tuck
	
    @param  width    in yards
	@param  length   in yards
*/
record CornField(float width, float height) {
	/**
	    Gets the cost of fuel to plow the field.
	
        @param  dieselPrice    dollars per gallon
		@return                the cost in dollars to fully plow
    */
    float plowingCost(float dieselPrice) {
       // ...
	}
}
```

Class example:

```java
/**
	Implements a sieve algorithm to calculate the prime
	factorization of an integer.
	
	@author Nat Tuck
*/
class Factor {
	/**
	    The program's main method
	
	    @param  args    	input number goes in args[0]
	*/
	public static void main(String[] args) {
        // ...
	}
	
	/**
	    Factor an integer to its prime factors
		
		@param  xx      number to factor
		@return         the prime factors
	*/	
	public static ArrayList<Long> factor(long xx) {
		// ...
	}
}
```

### Requirements

 * Every class or record must have a Javadoc comment.
 * The first sentence of a Javadoc comment must describe the thing.
 * Each public class or record must have at least one @author tag.
 * Each method or record must have a @param tag for each parameter.
 * Each method that returns stuff must have a @return tag stating what
   it returns.
 * If there's anything to say (e.g. units), the Javadoc comment should 
   include it.
 * If there's really nothing to say (e.g. simple main method) but a comment
   is required then a trivial comment is sufficient. 


### External Resources

The JavaDoc conventions used for the Java project itself are 
[available from Oracle](
https://www.oracle.com/technical-resources/articles/java/javadoc-tool.html).

The spec includes [a list of legal @tags](
https://docs.oracle.com/en/java/javase/13/docs/specs/javadoc/doc-comment-spec.html)
