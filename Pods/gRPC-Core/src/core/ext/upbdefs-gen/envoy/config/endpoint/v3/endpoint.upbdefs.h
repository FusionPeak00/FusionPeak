/* This file was generated by upb_generator from the input file:
 *
 *     envoy/config/endpoint/v3/endpoint.proto
 *
 * Do not edit -- your changes will be discarded when the file is
 * regenerated. */

#ifndef ENVOY_CONFIG_ENDPOINT_V3_ENDPOINT_PROTO_UPBDEFS_H_
#define ENVOY_CONFIG_ENDPOINT_V3_ENDPOINT_PROTO_UPBDEFS_H_

#include "upb/reflection/def.h"
#include "upb/reflection/internal/def_pool.h"

#include "upb/port/def.inc" // Must be last.
#ifdef __cplusplus
extern "C" {
#endif

extern _upb_DefPool_Init envoy_config_endpoint_v3_endpoint_proto_upbdefinit;

UPB_INLINE const upb_MessageDef *envoy_config_endpoint_v3_ClusterLoadAssignment_getmsgdef(upb_DefPool *s) {
  _upb_DefPool_LoadDefInit(s, &envoy_config_endpoint_v3_endpoint_proto_upbdefinit);
  return upb_DefPool_FindMessageByName(s, "envoy.config.endpoint.v3.ClusterLoadAssignment");
}

UPB_INLINE const upb_MessageDef *envoy_config_endpoint_v3_ClusterLoadAssignment_Policy_getmsgdef(upb_DefPool *s) {
  _upb_DefPool_LoadDefInit(s, &envoy_config_endpoint_v3_endpoint_proto_upbdefinit);
  return upb_DefPool_FindMessageByName(s, "envoy.config.endpoint.v3.ClusterLoadAssignment.Policy");
}

UPB_INLINE const upb_MessageDef *envoy_config_endpoint_v3_ClusterLoadAssignment_Policy_DropOverload_getmsgdef(upb_DefPool *s) {
  _upb_DefPool_LoadDefInit(s, &envoy_config_endpoint_v3_endpoint_proto_upbdefinit);
  return upb_DefPool_FindMessageByName(s, "envoy.config.endpoint.v3.ClusterLoadAssignment.Policy.DropOverload");
}

UPB_INLINE const upb_MessageDef *envoy_config_endpoint_v3_ClusterLoadAssignment_NamedEndpointsEntry_getmsgdef(upb_DefPool *s) {
  _upb_DefPool_LoadDefInit(s, &envoy_config_endpoint_v3_endpoint_proto_upbdefinit);
  return upb_DefPool_FindMessageByName(s, "envoy.config.endpoint.v3.ClusterLoadAssignment.NamedEndpointsEntry");
}

#ifdef __cplusplus
}  /* extern "C" */
#endif

#include "upb/port/undef.inc"

#endif  /* ENVOY_CONFIG_ENDPOINT_V3_ENDPOINT_PROTO_UPBDEFS_H_ */
