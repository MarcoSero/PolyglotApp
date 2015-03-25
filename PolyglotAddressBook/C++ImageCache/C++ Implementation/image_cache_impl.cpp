//
//  ImageCache.cpp
//  data-test
//
//  Created by Marco Sero on 09/03/2015.
//  Copyright (c) 2015 Marco Sero. All rights reserved.
//

#include "image_cache_impl.hpp"
#include <fstream>
#include <iostream>

using namespace std;

shared_ptr<ImageCache> ImageCache::create_with_path(const string &path)
{
    auto cache = make_shared<ImageCacheImpl>(path);
    return cache;
}

string ImageCacheImpl::cache_path()
{
    return path;
}

vector<uint8_t> ImageCacheImpl::image_for_key(const string &key)
{
    vector<uint8_t> image_data = in_memory_image_for_key(key);
    if (image_data.size() > 0) {
        return image_data;
    }

    image_data = on_disk_image_for_key(key);
    if (image_data.size() > 0) {
        in_memory_save_image_for_key(key, image_data);
    }
    return image_data;
}

void ImageCacheImpl::save_image_for_key(const string &key, const vector<uint8_t> &image_data)
{
    in_memory_save_image_for_key(key, image_data);
    on_disk_save_image_for_key(key, image_data);
}

vector<uint8_t> ImageCacheImpl::in_memory_image_for_key(const string &key)
{
    auto iterator = memory_cache.find(key);
    if (iterator == memory_cache.end()) {
        return vector<uint8_t>(0);
    }
    pair<string, vector<uint8_t>> key_value = *iterator;
    return key_value.second;
}

vector<uint8_t> ImageCacheImpl::on_disk_image_for_key(const string &key)
{
    vector<uint8_t> bytes;
    ifstream file(file_path_for_key(key), ios_base::in | ios_base::binary);
    uint8_t ch = (uint8_t)file.get();
    while (file.good()) {
        bytes.push_back(ch);
        ch = (uint8_t)file.get();
    }
    return bytes;
}

void ImageCacheImpl::in_memory_save_image_for_key(const string &key, const vector<uint8_t> &image_data)
{
    memory_cache.emplace(key, image_data);
}

void ImageCacheImpl::on_disk_save_image_for_key(const string &key, const vector<uint8_t> &image_data)
{
    uint8_t *image_data_array = (uint8_t *)&image_data[0];
    ofstream fp;
    fp.open(file_path_for_key(key), ios::out | ios::binary);
    fp.write((char *)image_data_array, sizeof(uint8_t) * image_data.size());
    fp.close();
}

string ImageCacheImpl::file_path_for_key(const string &key)
{
    string filename = path + "/" + key;
    return filename;
}
