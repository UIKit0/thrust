/*
 *  Copyright 2008-2011 NVIDIA Corporation
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

#pragma once

#include <thrust/detail/config.h>
#include <thrust/detail/functional/actor.h>
#include <thrust/detail/functional/composite.h>
#include <thrust/detail/functional/operators/operator_adaptors.h>

namespace thrust
{
namespace detail
{
namespace functional
{

template<typename T>
  struct plus_equal
    : public thrust::binary_function<T&,T,T&>
{
  __host__ __device__ T& operator()(T &lhs, const T &rhs) const { return lhs += rhs; }
}; // end plus_equal

template<typename T1, typename T2>
__host__ __device__
actor<
  composite<
    binary_operator<plus_equal>,
    typename as_actor<T1>::type,
    typename as_actor<T2>::type
  >
>
operator+=(const T1 &_1, const T2 &_2)
{
  return compose(binary_operator<plus_equal>(),
                 as_actor<T1>::convert(_1),
                 as_actor<T2>::convert(_2));
} // end operator+=()

template<typename T>
  struct minus_equal
    : public thrust::binary_function<T&,T,T&>
{
  __host__ __device__ T& operator()(T &lhs, const T &rhs) const { return lhs -= rhs; }
}; // end minus_equal

template<typename T1, typename T2>
__host__ __device__
actor<
  composite<
    binary_operator<minus_equal>,
    typename as_actor<T1>::type,
    typename as_actor<T2>::type
  >
>
operator-=(const T1 &_1, const T2 &_2)
{
  return compose(binary_operator<minus_equal>(),
                 as_actor<T1>::convert(_1),
                 as_actor<T2>::convert(_2));
} // end operator-=()

template<typename T>
  struct multiplies_equal
    : public thrust::binary_function<T&,T,T&>
{
  __host__ __device__ T& operator()(T &lhs, const T&rhs) const { return lhs *= rhs; }
}; // end multiplies_equal

template<typename T1, typename T2>
__host__ __device__
actor<
  composite<
    binary_operator<multiplies_equal>,
    typename as_actor<T1>::type,
    typename as_actor<T2>::type
  >
>
operator*=(const T1 &_1, const T2 &_2)
{
  return compose(binary_operator<multiplies_equal>(),
                 as_actor<T1>::convert(_1),
                 as_actor<T2>::convert(_2));
} // end operator*=()

template<typename T>
  struct divides_equal
    : public thrust::binary_function<T&,T,T&>
{
  __host__ __device__ T& operator()(T &lhs, const T&rhs) const { return lhs /= rhs; }
}; // end divides_equal

template<typename T1, typename T2>
__host__ __device__
actor<
  composite<
    binary_operator<divides_equal>,
    typename as_actor<T1>::type,
    typename as_actor<T2>::type
  >
>
operator/=(const T1 &_1, const T2 &_2)
{
  return compose(binary_operator<divides_equal>(),
                 as_actor<T1>::convert(_1),
                 as_actor<T2>::convert(_2));
} // end operator/=()

template<typename T>
  struct modulus_equal
    : public thrust::binary_function<T&,T,T&>
{
  __host__ __device__ T& operator()(T &lhs, const T&rhs) const { return lhs %= rhs; }
}; // end modulus_equal

template<typename T1, typename T2>
__host__ __device__
actor<
  composite<
    binary_operator<modulus_equal>,
    typename as_actor<T1>::type,
    typename as_actor<T2>::type
  >
>
operator%=(const T1 &_1, const T2 &_2)
{
  return compose(binary_operator<modulus_equal>(),
                 as_actor<T1>::convert(_1),
                 as_actor<T2>::convert(_2));
} // end operator%=()

template<typename T>
  struct bit_and_equal
    : public thrust::binary_function<T&,T,T&>
{
  __host__ __device__ T& operator()(T &lhs, const T&rhs) const { return lhs &= rhs; }
}; // end bit_and_equal

template<typename T1, typename T2>
__host__ __device__
actor<
  composite<
    binary_operator<bit_and_equal>,
    typename as_actor<T1>::type,
    typename as_actor<T2>::type
  >
>
operator&=(const T1 &_1, const T2 &_2)
{
  return compose(binary_operator<bit_and_equal>(),
                 as_actor<T1>::convert(_1),
                 as_actor<T2>::convert(_2));
} // end operator&=()

template<typename T>
  struct bit_or_equal
    : public thrust::binary_function<T&,T,T&>
{
  __host__ __device__ T& operator()(T &lhs, const T&rhs) const { return lhs |= rhs; }
}; // end bit_or_equal

template<typename T1, typename T2>
__host__ __device__
actor<
  composite<
    binary_operator<bit_or_equal>,
    typename as_actor<T1>::type,
    typename as_actor<T2>::type
  >
>
operator|=(const T1 &_1, const T2 &_2)
{
  return compose(binary_operator<bit_or_equal>(),
                 as_actor<T1>::convert(_1),
                 as_actor<T2>::convert(_2));
} // end operator|=()

template<typename T>
  struct bit_xor_equal
    : public thrust::binary_function<T&,T,T&>
{
  __host__ __device__ T& operator()(T &lhs, const T&rhs) const { return lhs ^= rhs; }
}; // end bit_xor_equal

template<typename T1, typename T2>
__host__ __device__
actor<
  composite<
    binary_operator<bit_xor_equal>,
    typename as_actor<T1>::type,
    typename as_actor<T2>::type
  >
>
operator^=(const T1 &_1, const T2 &_2)
{
  return compose(binary_operator<bit_xor_equal>(),
                 as_actor<T1>::convert(_1),
                 as_actor<T2>::convert(_2));
} // end operator|=()

template<typename T>
  struct bit_lshift_equal
    : public thrust::binary_function<T&,T,T&>
{
  __host__ __device__ T& operator()(T &lhs, const T&rhs) const { return lhs <<= rhs; }
}; // end bit_lshift_equal

template<typename T1, typename T2>
__host__ __device__
actor<
  composite<
    binary_operator<bit_lshift_equal>,
    typename as_actor<T1>::type,
    typename as_actor<T2>::type
  >
>
operator<<=(const T1 &_1, const T2 &_2)
{
  return compose(binary_operator<bit_lshift_equal>(),
                 as_actor<T1>::convert(_1),
                 as_actor<T2>::convert(_2));
} // end operator<<=()

template<typename T>
  struct bit_rshift_equal
    : public thrust::binary_function<T&,T,T&>
{
  __host__ __device__ T& operator()(T &lhs, const T&rhs) const { return lhs >>= rhs; }
}; // end bit_rshift_equal

template<typename T1, typename T2>
__host__ __device__
actor<
  composite<
    binary_operator<bit_rshift_equal>,
    typename as_actor<T1>::type,
    typename as_actor<T2>::type
  >
>
operator>>=(const T1 &_1, const T2 &_2)
{
  return compose(binary_operator<bit_rshift_equal>(),
                 as_actor<T1>::convert(_1),
                 as_actor<T2>::convert(_2));
} // end operator>>=()

} // end functional
} // end detail
} // end thrust

