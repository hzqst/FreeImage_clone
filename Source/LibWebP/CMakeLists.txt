# LibWebP静态库 - 基于原始Visual Studio项目文件
set(LIBWEBP_SOURCES
    # 解码相关
    src/dec/alpha_dec.c
    src/dec/buffer_dec.c
    src/dec/frame_dec.c
    src/dec/idec_dec.c
    src/dec/io_dec.c
    src/dec/quant_dec.c
    src/dec/tree_dec.c
    src/dec/vp8l_dec.c
    src/dec/vp8_dec.c
    src/dec/webp_dec.c
    
    # 解复用相关
    src/demux/anim_decode.c
    src/demux/demux.c
    
    # DSP优化
    src/dsp/alpha_processing.c
    src/dsp/alpha_processing_sse2.c
    src/dsp/alpha_processing_sse41.c
    src/dsp/cost.c
    src/dsp/cost_sse2.c
    src/dsp/cpu.c
    src/dsp/dec.c
    src/dsp/dec_clip_tables.c
    src/dsp/dec_sse2.c
    src/dsp/dec_sse41.c
    src/dsp/enc.c
    src/dsp/enc_sse2.c
    src/dsp/enc_sse41.c
    src/dsp/filters.c
    src/dsp/filters_sse2.c
    src/dsp/lossless.c
    src/dsp/lossless_enc.c
    src/dsp/lossless_enc_sse2.c
    src/dsp/lossless_enc_sse41.c
    src/dsp/lossless_sse2.c
    src/dsp/rescaler.c
    src/dsp/rescaler_sse2.c
    src/dsp/ssim.c
    src/dsp/ssim_sse2.c
    src/dsp/upsampling.c
    src/dsp/upsampling_sse2.c
    src/dsp/upsampling_sse41.c
    src/dsp/yuv.c
    src/dsp/yuv_sse2.c
    src/dsp/yuv_sse41.c
    
    # 编码相关
    src/enc/alpha_enc.c
    src/enc/analysis_enc.c
    src/enc/backward_references_cost_enc.c
    src/enc/backward_references_enc.c
    src/enc/config_enc.c
    src/enc/cost_enc.c
    src/enc/filter_enc.c
    src/enc/frame_enc.c
    src/enc/histogram_enc.c
    src/enc/iterator_enc.c
    src/enc/near_lossless_enc.c
    src/enc/picture_csp_enc.c
    src/enc/picture_enc.c
    src/enc/picture_psnr_enc.c
    src/enc/picture_rescale_enc.c
    src/enc/picture_tools_enc.c
    src/enc/predictor_enc.c
    src/enc/quant_enc.c
    src/enc/syntax_enc.c
    src/enc/token_enc.c
    src/enc/tree_enc.c
    src/enc/vp8l_enc.c
    src/enc/webp_enc.c
    
    # 多路复用
    src/mux/anim_encode.c
    src/mux/muxedit.c
    src/mux/muxinternal.c
    src/mux/muxread.c
    
    # 工具函数
    src/utils/bit_reader_utils.c
    src/utils/bit_writer_utils.c
    src/utils/color_cache_utils.c
    src/utils/filters_utils.c
    src/utils/huffman_encode_utils.c
    src/utils/huffman_utils.c
    src/utils/quant_levels_dec_utils.c
    src/utils/quant_levels_utils.c
    src/utils/random_utils.c
    src/utils/rescaler_utils.c
    src/utils/thread_utils.c
    src/utils/utils.c
)

add_library(LibWebP STATIC ${LIBWEBP_SOURCES})

# 设置编译为C语言
set_target_properties(LibWebP PROPERTIES
    C_STANDARD 99
    C_STANDARD_REQUIRED ON
)

# 设置预处理器定义
target_compile_definitions(LibWebP PRIVATE
    WIN32_LEAN_AND_MEAN
)

if(WIN32)
    target_compile_definitions(LibWebP PRIVATE
        WIN32
        _WINDOWS
        _LIB
    )
endif()

# 设置包含目录 - 关键是要包含当前源目录作为根目录
target_include_directories(LibWebP PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
    $<INSTALL_INTERFACE:include/webp>
)

# 设置输出名称
set_target_properties(LibWebP PROPERTIES
    OUTPUT_NAME "webp"
    DEBUG_POSTFIX "d"
) 