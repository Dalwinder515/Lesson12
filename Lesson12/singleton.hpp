//
//  singleton.hpp
//  Lesson12
//
//  Created by Student on 2019-11-27.
//  Copyright © 2019 CentennialCollege. All rights reserved.
//

#ifndef singleton_hpp
#define singleton_hpp

#include <stdio.h>


class singleton{
    
public:
    static singleton* getInstance()
    {
        if(instance==nullptr)
        {
            instance = new singleton();
            return instance;
        }
        return instance;
    }
private:
    static singleton* instance;
    
    singleton();



#endif /* singleton_hpp */
};
