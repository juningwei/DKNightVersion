# -*- coding: utf-8 -*-

module ObjcClassNightCategory

	def night_interface_string
		<<-OBJECT_C
//
//  #{name}+NightVersion.h
//  #{name}+NightVersion
//
//  Copyright (c) 2015 Draveness. All rights reserved.
//
//  These files are generated by ruby script, if you want to modify code
//  in this file, you are supposed to update the ruby code, run it and 
//  test it. And finally open a pull request.

#import <UIKit/UIKit.h>
#{night_interface_import_string}
@interface #{name} (NightVersion)

- (void)changeColor;

@end
		OBJECT_C
	end

	def night_interface_import_string
		properties.map { |property|
			"#import \"" + name + "+#{property.cap_name}.h\"\n"
		}.join
	end

	def night_implementation_string
		<<-OBJECT_C
//
//  #{name}+NightVersion.m
//  #{name}+NightVersion
//
//  Copyright (c) 2015 Draveness. All rights reserved.
//
//  These files are generated by ruby script, if you want to modify code
//  in this file, you are supposed to update the ruby code, run it and 
//  test it. And finally open a pull request.

#import "#{name}+NightVersion.h"
#{night_implementation_superclass_string}
#import "DKNightVersionManager.h"
#import "DKNightVersionConstants.h"

@implementation #{name} (NightVersion)

#pragma mark - TransformColor

- (void)changeColor {
    #{night_implementation_method_string}[UIView animateWithDuration:NIGHT_ANIMATION_DURATION animations:^{
        #{night_implementation_property_string}
    }];
}

@end
		OBJECT_C
	end

	def night_implementation_superclass_string
		superclass ? "#import \"#{superclass}+NightVersion.h\"" : ""
	end

	def night_implementation_method_string
		superclass ? "[super changeColor];\n    " : ""
	end

	def night_implementation_property_string
		properties.map { |property|
			"[self set#{property.cap_name}:([DKNightVersionManager currentThemeVersion] == DKThemeVersionNight) ? \
self.night#{property.cap_name} : self.normal#{property.cap_name}#{property.selector_name}#{property.parameter}];"
		}.join
	end

end
