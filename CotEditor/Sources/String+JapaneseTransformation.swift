//
//  String+JapaneseTransform.swift
//
//  CotEditor
//  https://coteditor.com
//
//  Created by 1024jp on 2014-07-31.
//
//  ---------------------------------------------------------------------------
//
//  © 2014-2018 1024jp
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  https://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

extension StringProtocol {
    
    // MARK: Public Properties
    
    /// transform half-width roman to full-width
    var fullWidthRoman: String {
        
        return self.unicodeScalars
            .map { scalar -> Unicode.Scalar in
                guard Unicode.Scalar.fullWidthAvailableRange.contains(scalar) else { return scalar }
                
                return Unicode.Scalar(scalar.value + Unicode.Scalar.characterWidthDistance)!
            }
            .reduce(into: "") { (string, scalar) in
                string.unicodeScalars.append(scalar)
            }
    }
    
    
    /// transform full-width roman to half-width
    var halfWidthRoman: String {
        
        return self.unicodeScalars
            .map { scalar -> Unicode.Scalar in
                guard Unicode.Scalar.fullWidthRange.contains(scalar) else { return scalar }
                
                return Unicode.Scalar(scalar.value - Unicode.Scalar.characterWidthDistance)!
            }
            .reduce(into: "") { (string, scalar) in
                string.unicodeScalars.append(scalar)
            }
    }
    
}



// MARK: - Private Extensions

private extension Unicode.Scalar {
    
    static let fullWidthRange = Self("！")...Self("～")
    static let fullWidthAvailableRange = Self("!")...Self("~")
    
    static let characterWidthDistance = Self.fullWidthRange.lowerBound.value - Self.fullWidthAvailableRange.lowerBound.value
}
