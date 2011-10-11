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


/*! \file transform_reduce.inl
 *  \brief Inline file for transform_reduce.h.
 */

#include <thrust/detail/config.h>
#include <thrust/detail/backend/generic/select_system.h>
#include <thrust/detail/backend/generic/transform_reduce.h>
#include <thrust/iterator/iterator_traits.h>

namespace thrust
{

template<typename InputIterator, 
         typename UnaryFunction, 
         typename OutputType,
         typename BinaryFunction>
  OutputType transform_reduce(InputIterator first,
                              InputIterator last,
                              UnaryFunction unary_op,
                              OutputType init,
                              BinaryFunction binary_op)
{
  using thrust::detail::backend::generic::select_system;
  using thrust::detail::backend::generic::transform_reduce;

  typedef typename thrust::iterator_space<InputIterator>::type space;

  return transform_reduce(select_system(space()), first, last, unary_op, init, binary_op);
} // end transform_reduce()

} // end namespace thrust

