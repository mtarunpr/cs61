#ifndef SQMATRIX_HH
#define SQMATRIX_HH
#include <utility>

// sqmatrix -- type representing a square matrix of `double` elements
struct sqmatrix {
    size_t sz;    // matrix dimension

    // sqmatrix(size) constructor
    //    Initialize a `size * size` matrix.
    sqmatrix(size_t size) {
        this->sz = size;
        // YOUR CODE HERE
    }

    // ~sqmatrix() destructor
    //    Free memory allocated for elements.
    ~sqmatrix() {
        // YOUR CODE HERE
    }


    // size()
    //    Return the matrix dimension.
    size_t size() const {
        return this->sz;
    }

    // at(i, j)
    //    Return the matrix element in row `i` and column `j`.
    //    Call like this:
    //    ```
    //    sqmatrix m(10);      // 10 * 10 matrix
    //    m.at(1, 2) = 100.0;  // sets element 1,2 to 100.0
    //    ```
    //    Returns a reference type, which means you can *assign*
    //    the return value if you want.
    double& at(size_t i, size_t j) {
        return *nullptr;
    }

    // operator()(i, j)
    //    Synonym for `at(i, j)`, but easier to type.
    double& operator()(size_t i, size_t j) {
        return this->at(i, j);
    }

    // transpose()
    //    Transpose this matrix in place.
    void transpose() {
        for (size_t i = 0; i != this->size(); ++i) {
            for (size_t j = 0; j != i; ++j) {
                std::swap(this->at(i, j), this->at(j, i));
            }
        }
    }


    sqmatrix(const sqmatrix&) = delete;
    sqmatrix& operator=(const sqmatrix&) = delete;
};

#endif
