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

import Foundation
import RealmSwift

protocol TrivialCustomPersistable: CustomPersistable {
    var value: PersistedType { get set }
    init(value: PersistedType)
}

extension TrivialCustomPersistable {
    init(persistedValue: PersistedType) {
        self.init(value: persistedValue)
    }
    var persistableValue: PersistedType { value }
}

struct BoolWrapper: TrivialCustomPersistable {
    typealias PersistedType = Bool
    var value: Bool
}
struct IntWrapper: TrivialCustomPersistable {
    typealias PersistedType = Int
    var value: Int
}
struct Int8Wrapper: TrivialCustomPersistable {
    typealias PersistedType = Int8
    var value: Int8
}
struct Int16Wrapper: TrivialCustomPersistable {
    typealias PersistedType = Int16
    var value: Int16
}
struct Int32Wrapper: TrivialCustomPersistable {
    typealias PersistedType = Int32
    var value: Int32
}
struct Int64Wrapper: TrivialCustomPersistable {
    typealias PersistedType = Int64
    var value: Int64
}
struct FloatWrapper: TrivialCustomPersistable {
    typealias PersistedType = Float
    var value: Float
}
struct DoubleWrapper: TrivialCustomPersistable {
    typealias PersistedType = Double
    var value: Double
}
struct StringWrapper: TrivialCustomPersistable {
    typealias PersistedType = String
    var value: String
}
struct DataWrapper: TrivialCustomPersistable {
    typealias PersistedType = Data
    var value: Data
}
struct DateWrapper: TrivialCustomPersistable {
    typealias PersistedType = Date
    var value: Date
}
struct Decimal128Wrapper: TrivialCustomPersistable {
    typealias PersistedType = Decimal128
    var value: Decimal128
}
struct ObjectIdWrapper: TrivialCustomPersistable {
    typealias PersistedType = ObjectId
    var value: ObjectId
}
struct UUIDWrapper: TrivialCustomPersistable {
    typealias PersistedType = UUID
    var value: UUID
}

// MARK: EmbeddedObject custom persistable wrappers

struct EmbeddedObjectWrapper: CustomPersistable {
    typealias PersistedType = ModernEmbeddedTreeObject1
    init(persistedValue: PersistedType) {
        self.value = persistedValue.value
    }
    var persistableValue: ModernEmbeddedTreeObject1 {
        return ModernEmbeddedTreeObject1(value: [value])
    }

    var value: Int
}

class AllCustomPersistableTypes: Object {
    @Persisted var bool: BoolWrapper
    @Persisted var int: IntWrapper
    @Persisted var int8: Int8Wrapper
    @Persisted var int16: Int16Wrapper
    @Persisted var int32: Int32Wrapper
    @Persisted var int64: Int64Wrapper
    @Persisted var float: FloatWrapper
    @Persisted var double: DoubleWrapper
    @Persisted var string: StringWrapper
    @Persisted var binary: DataWrapper
    @Persisted var date: DateWrapper
    @Persisted var decimal: Decimal128Wrapper
    @Persisted var objectId: ObjectIdWrapper
    @Persisted var object: EmbeddedObjectWrapper

    @Persisted var optBool: BoolWrapper?
    @Persisted var optInt: IntWrapper?
    @Persisted var optInt8: Int8Wrapper?
    @Persisted var optInt16: Int16Wrapper?
    @Persisted var optInt32: Int32Wrapper?
    @Persisted var optInt64: Int64Wrapper?
    @Persisted var optFloat: FloatWrapper?
    @Persisted var optDouble: DoubleWrapper?
    @Persisted var optString: StringWrapper?
    @Persisted var optBinary: DataWrapper?
    @Persisted var optDate: DateWrapper?
    @Persisted var optDecimal: Decimal128Wrapper?
    @Persisted var optObjectId: ObjectIdWrapper?
    @Persisted var optObject: EmbeddedObjectWrapper?

    @Persisted var listBool: List<BoolWrapper>
    @Persisted var listInt: List<IntWrapper>
    @Persisted var listInt8: List<Int8Wrapper>
    @Persisted var listInt16: List<Int16Wrapper>
    @Persisted var listInt32: List<Int32Wrapper>
    @Persisted var listInt64: List<Int64Wrapper>
    @Persisted var listFloat: List<FloatWrapper>
    @Persisted var listDouble: List<DoubleWrapper>
    @Persisted var listString: List<StringWrapper>
    @Persisted var listBinary: List<DataWrapper>
    @Persisted var listDate: List<DateWrapper>
    @Persisted var listDecimal: List<Decimal128Wrapper>
    @Persisted var listObjectId: List<ObjectIdWrapper>
    @Persisted var listObject: List<EmbeddedObjectWrapper>

    @Persisted var listOptBool: List<BoolWrapper?>
    @Persisted var listOptInt: List<IntWrapper?>
    @Persisted var listOptInt8: List<Int8Wrapper?>
    @Persisted var listOptInt16: List<Int16Wrapper?>
    @Persisted var listOptInt32: List<Int32Wrapper?>
    @Persisted var listOptInt64: List<Int64Wrapper?>
    @Persisted var listOptFloat: List<FloatWrapper?>
    @Persisted var listOptDouble: List<DoubleWrapper?>
    @Persisted var listOptString: List<StringWrapper?>
    @Persisted var listOptBinary: List<DataWrapper?>
    @Persisted var listOptDate: List<DateWrapper?>
    @Persisted var listOptDecimal: List<Decimal128Wrapper?>
    @Persisted var listOptObjectId: List<ObjectIdWrapper?>
}
