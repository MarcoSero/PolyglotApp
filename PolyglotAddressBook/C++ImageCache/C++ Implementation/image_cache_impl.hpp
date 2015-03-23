//
//  ImageCache.h
//  data-test
//
//  Created by Marco Sero on 09/03/2015.
//  Copyright (c) 2015 Marco Sero. All rights reserved.
//

#pragma once

#include "image_cache.hpp"
#include <stdio.h>
#include <vector>
#include <string>
#include <map>

class ImageCacheImpl : public ImageCache {

public:
    ImageCacheImpl(const std::string p) : path(p) {};

private:

    // superclass public interface
    virtual std::string cache_path();
    virtual std::vector<uint8_t> image_for_key(const std::string & key);
    virtual void save_image_for_key(const std::string & key, const std::vector<uint8_t> & image_data);

    // internals
    std::string path;

    std::map<std::string, std::vector<uint8_t>> memory_cache;

    std::vector<uint8_t> in_memory_image_for_key(const std::string &key);
    std::vector<uint8_t> on_disk_image_for_key(const std::string &key);

    void in_memory_save_image_for_key(const std::string &key, const std::vector<uint8_t> &image_data);
    void on_disk_save_image_for_key(const std::string &key, const std::vector<uint8_t> &image_data);

    std::string file_path_for_key(const std::string &key);
};