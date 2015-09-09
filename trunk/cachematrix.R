## Programmer: Eric W. Bruce CFA, CAIA
## Description: Pair of functions that cache and compute the inverse of a matrix.

## makeCacheMatrix returns a "matrix" object that caches its inverse.
## ------------------------------------------------------------------
makeCacheMatrix <- function(mtx = matrix()) {
  inverse <- NULL
  set <- function(x) {
    mtx <<- x;
    inverse <<- NULL;
  }
  get <- function() return(mtx);
  setinv <- function(inv) inverse <<- inv;
  getinv <- function() return(inverse);
  return(list(set = set, get = get, setinv = setinv, getinv = getinv))
}
## ------------------------------------------------------------------

## cacheSolve computes and returns the inverse of the "matrix" returned by `makeCacheMatrix` above. If the inverse has
## already been computed (and the matrix has not changed), then `cacheSolve` returns the inverse from the cache which is
## much quicker.
## ------------------------------------------------------------------
cacheSolve <- function(mtx, ...) {
  inverse <- mtx$getinv()
  if(!is.null(inverse)) {
    message("Getting cached data...")
    return(inverse)
  }
  data <- mtx$get()
  invserse <- solve(data, ...)
  mtx$setinv(inverse)
  return(inverse)
}
## ------------------------------------------------------------------