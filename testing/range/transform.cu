#include <unittest/unittest.h>
#include <thrust/range/algorithm/transform.h>
#include <thrust/iterator/counting_iterator.h>

template <class Vector>
void TestRangeTransformUnarySimple(void)
{
    typedef typename Vector::value_type T;

    Vector input(3);
    Vector output(3);
    Vector result(3);
    input[0]  =  1; input[1]  = -2; input[2]  =  3;
    result[0] = -1; result[1] =  2; result[2] = -3;

    size_t result_size = thrust::experimental::range::transform(input, output, thrust::negate<T>()).size();
    
    ASSERT_EQUAL(0, result_size);
    ASSERT_EQUAL(output, result);
}
DECLARE_VECTOR_UNITTEST(TestRangeTransformUnarySimple);


template <class Vector>
void TestRangeTransformIfUnarySimple(void)
{
    typedef typename Vector::value_type T;

    Vector input(3);
    Vector stencil(3);
    Vector output(3);
    Vector result(3);

    input[0]   =  1; input[1]   = -2; input[2]   =  3;
    output[0]  =  1; output[1]  =  2; output[2]  =  3; 
    stencil[0] =  1; stencil[1] =  0; stencil[2] =  1;
    result[0]  = -1; result[1]  =  2; result[2]  = -3;

    size_t result_size = thrust::experimental::range::transform_if(input,
                                                                   stencil,
                                                                   output,
                                                                   thrust::negate<T>(),
                                                                   thrust::identity<T>());
    
    ASSERT_EQUAL(0, result_size);
    ASSERT_EQUAL(output, result);
}
DECLARE_VECTOR_UNITTEST(TestRangeTransformIfUnarySimple);


template <class Vector>
void TestRangeTransformBinarySimple(void)
{
    typedef typename Vector::value_type T;

    Vector input1(3);
    Vector input2(3);
    Vector output(3);
    Vector result(3);
    input1[0] =  1; input1[1] = -2; input1[2] =  3;
    input2[0] = -4; input2[1] =  5; input2[2] =  6;
    result[0] =  5; result[1] = -7; result[2] = -3;

    size_t result_size = thrust::experimental::range::transform(input1, input2, output, thrust::minus<T>());
    
    ASSERT_EQUAL(0, result_size);
    ASSERT_EQUAL(output, result);
}
DECLARE_VECTOR_UNITTEST(TestRangeTransformBinarySimple);


template <class Vector>
void TestRangeTransformIfBinarySimple(void)
{
    typedef typename Vector::value_type T;

    Vector input1(3);
    Vector input2(3);
    Vector stencil(3);
    Vector output(3);
    Vector result(3);

    input1[0]  =  1; input1[1]  = -2; input1[2]  =  3;
    input2[0]  = -4; input2[1]  =  5; input2[2]  =  6;
    stencil[0] =  0; stencil[1] =  1; stencil[2] =  0;
    output[0]  =  1; output[1]  =  2; output[2]  =  3;
    result[0]  =  5; result[1]  =  2; result[2]  = -3;

    thrust::identity<T> identity;

    size_t result_size = thrust::experimental::range::transform_if(input1,
                                                                   input2,
                                                                   stencil,
                                                                   output,
                                                                   thrust::minus<T>(),
                                                                   thrust::not1(identity));
    
    ASSERT_EQUAL(0, result_size);
    ASSERT_EQUAL(output, result);
}
DECLARE_VECTOR_UNITTEST(TestRangeTransformIfBinarySimple);


template <typename T>
void TestRangeTransformUnary(const size_t n)
{
    thrust::host_vector<T>   h_input = unittest::random_integers<T>(n);
    thrust::device_vector<T> d_input = h_input;

    thrust::host_vector<T>   h_output(n);
    thrust::device_vector<T> d_output(n);

    thrust::experimental::range::transform(h_input, h_output, thrust::negate<T>());
    thrust::experimental::range::transform(d_input, d_output, thrust::negate<T>());
    
    ASSERT_EQUAL(h_output, d_output);
}
DECLARE_VARIABLE_UNITTEST(TestRangeTransformUnary);


struct is_positive
{
  template<typename T>
  __host__ __device__
  bool operator()(T &x)
  {
    return x > 0;
  } // end operator()()
}; // end is_positive


template <typename T>
void TestRangeTransformIfUnary(const size_t n)
{
    thrust::host_vector<T>   h_input   = unittest::random_integers<T>(n);
    thrust::host_vector<T>   h_stencil = unittest::random_integers<T>(n);
    thrust::host_vector<T>   h_output  = unittest::random_integers<T>(n);

    thrust::device_vector<T> d_input   = h_input;
    thrust::device_vector<T> d_stencil = h_stencil;
    thrust::device_vector<T> d_output  = h_output;

    thrust::experimental::range::transform_if(h_input,
                                              h_stencil,
                                              h_output,
                                              thrust::negate<T>(),
                                              is_positive());

    thrust::experimental::range::transform_if(d_input,
                                              d_stencil,
                                              d_output,
                                              thrust::negate<T>(),
                                              is_positive());
    
    ASSERT_EQUAL(h_output, d_output);
}
DECLARE_VARIABLE_UNITTEST(TestRangeTransformIfUnary);


template <typename T>
void TestRangeTransformBinary(const size_t n)
{
    thrust::host_vector<T>   h_input1 = unittest::random_integers<T>(n);
    thrust::host_vector<T>   h_input2 = unittest::random_integers<T>(n);
    thrust::device_vector<T> d_input1 = h_input1;
    thrust::device_vector<T> d_input2 = h_input2;

    thrust::host_vector<T>   h_output(n);
    thrust::device_vector<T> d_output(n);

    thrust::experimental::range::transform(h_input1, h_input2, h_output, thrust::minus<T>());
    thrust::experimental::range::transform(d_input1, d_input2, d_output, thrust::minus<T>());
    
    ASSERT_EQUAL(h_output, d_output);
    
    thrust::experimental::range::transform(h_input1, h_input2, h_output, thrust::multiplies<T>());
    thrust::experimental::range::transform(d_input1, d_input2, d_output, thrust::multiplies<T>());
    
    ASSERT_EQUAL(h_output, d_output);
}
DECLARE_VARIABLE_UNITTEST(TestRangeTransformBinary);


template <typename T>
void TestRangeTransformIfBinary(const size_t n)
{
    thrust::host_vector<T>   h_input1  = unittest::random_integers<T>(n);
    thrust::host_vector<T>   h_input2  = unittest::random_integers<T>(n);
    thrust::host_vector<T>   h_stencil = unittest::random_integers<T>(n);
    thrust::host_vector<T>   h_output  = unittest::random_integers<T>(n);

    thrust::device_vector<T> d_input1  = h_input1;
    thrust::device_vector<T> d_input2  = h_input2;
    thrust::device_vector<T> d_stencil = h_stencil;
    thrust::device_vector<T> d_output  = h_output;

    thrust::experimental::range::transform_if(h_input1,
                                              h_input2,
                                              h_stencil,
                                              h_output,
                                              thrust::minus<T>(),
                                              is_positive());

    thrust::experimental::range::transform_if(d_input1,
                                              d_input2,
                                              d_stencil,
                                              d_output,
                                              thrust::minus<T>(),
                                              is_positive());
    
    ASSERT_EQUAL(h_output, d_output);

    h_stencil = unittest::random_integers<T>(n);
    d_stencil = h_stencil;
    
    thrust::experimental::range::transform_if(h_input1,
                                              h_input2,
                                              h_stencil,
                                              h_output,
                                              thrust::multiplies<T>(),
                                              is_positive());

    thrust::experimental::range::transform_if(d_input1,
                                              d_input2,
                                              d_stencil,
                                              d_output,
                                              thrust::multiplies<T>(),
                                              is_positive());
    
    ASSERT_EQUAL(h_output, d_output);
}
DECLARE_VARIABLE_UNITTEST(TestRangeTransformIfBinary);


//template <class Vector>
//void TestTransformUnaryLazySequence(void)
//{
//    typedef typename Vector::value_type T;
//
//    thrust::counting_iterator<T> first(1);
//
//    Vector output(3);
//
//    thrust::transform(first, first + 3, output.begin(), thrust::identity<T>());
//    
//    Vector result(3);
//    result[0] = 1; result[1] = 2; result[2] = 3;
//
//    ASSERT_EQUAL(output, result);
//}
//DECLARE_VECTOR_UNITTEST(TestTransformUnaryLazySequence);
//
//template <class Vector>
//void TestTransformBinaryCountingIterator(void)
//{
//    typedef typename Vector::value_type T;
//
//    thrust::counting_iterator<T> first(1);
//
//    Vector output(3);
//
//    thrust::transform(first, first + 3, first, output.begin(), thrust::plus<T>());
//    
//    Vector result(3);
//    result[0] = 2; result[1] = 4; result[2] = 6;
//
//    ASSERT_EQUAL(output, result);
//}
//DECLARE_VECTOR_UNITTEST(TestTransformBinaryCountingIterator);


template <typename T>
struct plus_mod3 : public thrust::binary_function<T,T,T>
{
    T * table;

    plus_mod3(T * table) : table(table) {}

    __host__ __device__
    T operator()(T a, T b)
    {
        return table[(int) (a + b)];
    }
};

template <typename Vector>
void TestRangeTransformWithIndirection(void)
{
    // add numbers modulo 3 with external lookup table
    typedef typename Vector::value_type T;

    Vector input1(7);
    Vector input2(7);
    Vector output(7, 0);
    input1[0] = 0;  input2[0] = 2; 
    input1[1] = 1;  input2[1] = 2;
    input1[2] = 2;  input2[2] = 2;
    input1[3] = 1;  input2[3] = 0;
    input1[4] = 2;  input2[4] = 2;
    input1[5] = 0;  input2[5] = 1;
    input1[6] = 1;  input2[6] = 0;

    Vector table(6);
    table[0] = 0;
    table[1] = 1;
    table[2] = 2;
    table[3] = 0;
    table[4] = 1;
    table[5] = 2;

    thrust::experimental::range::transform(input1,
                                           input2, 
                                           output,
                                           plus_mod3<T>(thrust::raw_pointer_cast(&table[0])));
    
    ASSERT_EQUAL(output[0], T(2));
    ASSERT_EQUAL(output[1], T(0));
    ASSERT_EQUAL(output[2], T(1));
    ASSERT_EQUAL(output[3], T(1));
    ASSERT_EQUAL(output[4], T(1));
    ASSERT_EQUAL(output[5], T(1));
    ASSERT_EQUAL(output[6], T(1));
}
DECLARE_VECTOR_UNITTEST(TestRangeTransformWithIndirection);

