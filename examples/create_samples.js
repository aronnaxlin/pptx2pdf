#!/usr/bin/env node

/**
 * 创建简单的示例PPTX文件用于测试批量转换
 */

const PptxGenJS = require('pptxgenjs');

function createSamplePPTX(filename) {
    const pptx = new PptxGenJS();
    
    // 设置演示属性
    pptx.author = 'Alma AI';
    pptx.company = 'PPTX转换测试';
    pptx.title = '批量转换示例演示';
    
    // 幻灯片1 - 标题页
    const slide1 = pptx.addSlide();
    slide1.background = { color: '4a90e2' };
    
    slide1.addText('PPTX批量转换演示', {
        x: 1, y: 1.5, w: 8, h: 1.5,
        fontSize: 44,
        bold: true,
        color: 'ffffff',
        align: 'center',
        valign: 'middle'
    });
    
    slide1.addText('LibreOffice与在线工具对比', {
        x: 1, y: 3, w: 8, h: 1,
        fontSize: 24,
        color: 'ffffff',
        align: 'center'
    });
    
    slide1.addText('2026年3月', {
        x: 1, y: 4.5, w: 8, h: 0.5,
        fontSize: 16,
        color: 'e0e0e0',
        align: 'center'
    });
    
    // 幻灯片2 - 工具对比
    const slide2 = pptx.addSlide();
    slide2.background = { color: 'ffffff' };
    
    slide2.addText('转换工具对比', {
        x: 0.5, y: 0.5, w: 9, h: 1,
        fontSize: 36,
        bold: true,
        color: '4a90e2'
    });
    
    // LibreOffice列
    slide2.addText('LibreOffice', {
        x: 0.5, y: 1.8, w: 4, h: 0.8,
        fontSize: 24,
        bold: true,
        color: '28a745'
    });
    
    slide2.addText([
        { text: '• 免费开源\\r', options: { fontSize: 18 } },
        { text: '• 跨平台支持\\r', options: { fontSize: 18 } },
        { text: '• 批量转换\\r', options: { fontSize: 18 } },
        { text: '• 转换质量高', options: { fontSize: 18 } }
    ], {
        x: 0.5, y: 2.8, w: 4, h: 2
    });
    
    // 在线工具列
    slide2.addText('在线工具', {
        x: 5, y: 1.8, w: 4, h: 0.8,
        fontSize: 24,
        bold: true,
        color: 'dc3545'
    });
    
    slide2.addText([
        { text: '• 无需安装\\r', options: { fontSize: 18 } },
        { text: '• 需要网络\\r', options: { fontSize: 18 } },
        { text: '• 文件大小限制\\r', options: { fontSize: 18 } },
        { text: '• 隐私考虑', options: { fontSize: 18 } }
    ], {
        x: 5, y: 2.8, w: 4, h: 2
    });
    
    // 幻灯片3 - 使用步骤
    const slide3 = pptx.addSlide();
    slide3.background = { color: 'ffffff' };
    
    slide3.addText('使用步骤', {
        x: 0.5, y: 0.5, w: 9, h: 1,
        fontSize: 36,
        bold: true,
        color: 'ff6b6b',
        align: 'center'
    });
    
    // 步骤1
    slide3.addText('1', {
        x: 1, y: 2, w: 0.8, h: 0.8,
        fontSize: 24,
        bold: true,
        color: 'ffffff',
        fill: '2196f3',
        align: 'center',
        valign: 'middle'
    });
    
    slide3.addText('安装LibreOffice或选择在线工具', {
        x: 2, y: 2, w: 6, h: 0.8,
        fontSize: 20,
        valign: 'middle'
    });
    
    // 步骤2
    slide3.addText('2', {
        x: 1, y: 3, w: 0.8, h: 0.8,
        fontSize: 24,
        bold: true,
        color: 'ffffff',
        fill: '9c27b0',
        align: 'center',
        valign: 'middle'
    });
    
    slide3.addText('运行批量转换脚本', {
        x: 2, y: 3, w: 6, h: 0.8,
        fontSize: 20,
        valign: 'middle'
    });
    
    // 步骤3
    slide3.addText('3', {
        x: 1, y: 4, w: 0.8, h: 0.8,
        fontSize: 24,
        bold: true,
        color: 'ffffff',
        fill: '4caf50',
        align: 'center',
        valign: 'middle'
    });
    
    slide3.addText('获得PDF文件并检查结果', {
        x: 2, y: 4, w: 6, h: 0.8,
        fontSize: 20,
        valign: 'middle'
    });
    
    // 保存文件
    return pptx.writeFile({ fileName: filename });
}

async function createMultipleSamples() {
    console.log('📝 创建示例PPTX文件...');
    
    try {
        // 创建多个示例文件
        const files = [
            'test_files/demo_presentation.pptx',
            'test_files/sample_slides.pptx',
            'test_files/conversion_test.pptx'
        ];
        
        for (const file of files) {
            console.log(`🔄 创建: ${file}`);
            await createSamplePPTX(file);
            console.log(`✅ 完成: ${file}`);
        }
        
        console.log('\\n🎉 所有示例文件创建完成!');
        console.log('📁 文件位置: ./test_files/');
        
    } catch (error) {
        console.error('❌ 创建文件时出错:', error);
    }
}

// 主函数
if (require.main === module) {
    createMultipleSamples();
}

module.exports = { createSamplePPTX, createMultipleSamples };