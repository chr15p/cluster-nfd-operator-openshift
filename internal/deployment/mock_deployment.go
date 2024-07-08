// Code generated by MockGen. DO NOT EDIT.
// Source: deployment.go
//
// Generated by this command:
//
//	mockgen -source=deployment.go -package=deployment -destination=mock_deployment.go DeploymentAPI
//
// Package deployment is a generated GoMock package.
package deployment

import (
	context "context"
	reflect "reflect"

	gomock "go.uber.org/mock/gomock"
	v1 "k8s.io/api/apps/v1"
	v10 "github.com/openshift/cluster-nfd-operator/api/v1"
)

// MockDeploymentAPI is a mock of DeploymentAPI interface.
type MockDeploymentAPI struct {
	ctrl     *gomock.Controller
	recorder *MockDeploymentAPIMockRecorder
}

// MockDeploymentAPIMockRecorder is the mock recorder for MockDeploymentAPI.
type MockDeploymentAPIMockRecorder struct {
	mock *MockDeploymentAPI
}

// NewMockDeploymentAPI creates a new mock instance.
func NewMockDeploymentAPI(ctrl *gomock.Controller) *MockDeploymentAPI {
	mock := &MockDeploymentAPI{ctrl: ctrl}
	mock.recorder = &MockDeploymentAPIMockRecorder{mock}
	return mock
}

// EXPECT returns an object that allows the caller to indicate expected use.
func (m *MockDeploymentAPI) EXPECT() *MockDeploymentAPIMockRecorder {
	return m.recorder
}

// SetMasterDeploymentAsDesired mocks base method.
func (m *MockDeploymentAPI) SetMasterDeploymentAsDesired(ctx context.Context, nfdInstance *v10.NodeFeatureDiscovery, masterDep *v1.Deployment) error {
	m.ctrl.T.Helper()
	ret := m.ctrl.Call(m, "SetMasterDeploymentAsDesired", ctx, nfdInstance, masterDep)
	ret0, _ := ret[0].(error)
	return ret0
}

// SetMasterDeploymentAsDesired indicates an expected call of SetMasterDeploymentAsDesired.
func (mr *MockDeploymentAPIMockRecorder) SetMasterDeploymentAsDesired(ctx, nfdInstance, masterDep any) *gomock.Call {
	mr.mock.ctrl.T.Helper()
	return mr.mock.ctrl.RecordCallWithMethodType(mr.mock, "SetMasterDeploymentAsDesired", reflect.TypeOf((*MockDeploymentAPI)(nil).SetMasterDeploymentAsDesired), ctx, nfdInstance, masterDep)
}
