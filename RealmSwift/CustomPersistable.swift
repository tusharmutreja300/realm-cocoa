////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

import Foundation
import Realm

// MARK: Public API

public protocol CustomPersistable: _CustomPersistable {
    // Construct an instance of the user's type from the persisted type
    init(persistedValue: PersistedType)
    // Construct an instance of the persisted type from the user's type
    var persistableValue: PersistedType { get }
}

public protocol FailableCustomPersistable: _CustomPersistable {
    // Construct an instance of the user's type from the persisted type,
    // returning nil if the conversion is not possible
    init?(persistedValue: PersistedType)
    // Construct an instance of the persisted type from the user's type
    var persistableValue: PersistedType { get }
}

// MARK: - Implementation

public protocol _CustomPersistable: _OptionalPersistable, RealmCollectionValue where PersistedType: _OptionalPersistable {}

extension _CustomPersistable { // _RealmSchemaDiscoverable
    public static var _rlmType: PropertyType { PersistedType._rlmType }
    public static var _rlmOptional: Bool { PersistedType._rlmOptional }
    public static var _rlmRequireObjc: Bool { false }
    public func _rlmPopulateProperty(_ prop: RLMProperty) { }
    public static func _rlmPopulateProperty(_ prop: RLMProperty) {
        if prop.type == .object && !prop.collection {
            prop.optional = true
        }
        PersistedType._rlmPopulateProperty(prop)
    }
}

extension CustomPersistable { // _Persistable
    public static func _rlmGetProperty(_ obj: ObjectBase, _ key: PropertyKey) -> Self {
        return Self(persistedValue: PersistedType._rlmGetProperty(obj, key))
    }
    public static func _rlmGetPropertyOptional(_ obj: ObjectBase, _ key: PropertyKey) -> Self? {
        return PersistedType._rlmGetPropertyOptional(obj, key).flatMap(Self.init)
    }
    public static func _rlmSetProperty(_ obj: ObjectBase, _ key: PropertyKey, _ value: Self) {
        PersistedType._rlmSetProperty(obj, key, value.persistableValue)
    }
    public static func _rlmSetAccessor(_ prop: RLMProperty) {
        if prop.optional {
            prop.swiftAccessor = BridgedPersistedPropertyAccessor<Optional<Self>>.self
        } else {
            prop.swiftAccessor = BridgedPersistedPropertyAccessor<Self>.self
        }
    }

    public init() {
        self.init(persistedValue: PersistedType())
    }
}

extension FailableCustomPersistable { // _Persistable
    public static func _rlmGetProperty(_ obj: ObjectBase, _ key: PropertyKey) -> Self {
        return Self(persistedValue: PersistedType._rlmGetProperty(obj, key))!
    }
    public static func _rlmGetPropertyOptional(_ obj: ObjectBase, _ key: PropertyKey) -> Self? {
        return PersistedType._rlmGetPropertyOptional(obj, key).flatMap(Self.init)
    }
    public static func _rlmSetProperty(_ obj: ObjectBase, _ key: PropertyKey, _ value: Self) {
        PersistedType._rlmSetProperty(obj, key, value.persistableValue)
    }
    public static func _rlmSetAccessor(_ prop: RLMProperty) {
        if prop.optional {
            prop.swiftAccessor = BridgedPersistedPropertyAccessor<Optional<Self>>.self
        } else {
            prop.swiftAccessor = BridgedPersistedPropertyAccessor<Self>.self
        }
    }

    public init() {
        self.init(persistedValue: PersistedType())!
    }
}

extension CustomPersistable { // _ObjcBridgeable
    public static func _rlmFromObjc(_ value: Any) -> Self? {
        if let value = value as? PersistedType {
            return Self(persistedValue: value)
        }
        if let value = value as? Self {
            return value
        }
        return nil
    }
    public var _rlmObjcValue: Any { persistableValue }
}

extension FailableCustomPersistable { // _ObjcBridgeable
    public static func _rlmFromObjc(_ value: Any) -> Self? {
        if let value = value as? PersistedType {
            return Self(persistedValue: value)
        }
        if let value = value as? Self {
            return value
        }
        return nil
    }
    public var _rlmObjcValue: Any { persistableValue }
}
