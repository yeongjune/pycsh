package com.base.util;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.awt.image.ColorModel;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.Iterator;
import java.util.Random;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;

import com.mortennobel.imagescaling.DimensionConstrain;
import com.mortennobel.imagescaling.ResampleOp;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class ImageUitl {

	/**
	 * 限制最大宽高缩放并压缩图片
	 * @param is
	 * @param to
	 * @param maxWidth
	 * @param maxHeight
	 * @throws Exception
	 */
	public static void maxWidthHeight(InputStream is, File to, int maxWidth, int maxHeight) throws Exception{
		BufferedImage image = ImageIO.read(is);
		if(image==null)return;
		Integer width = image.getWidth();
		Integer height = image.getHeight();
		if(width>maxWidth || height>maxHeight){
			ResampleOp resampleOp = new ResampleOp(DimensionConstrain.createMaxDimension(maxWidth, maxHeight));
			BufferedImage rescaled = resampleOp.filter(image, null);
			ImageIO.write(rescaled, "png", to);
		}
	}
	public static void maxWidthHeight(InputStream is, String path, int maxWidth, int maxHeight) throws Exception{
		maxWidthHeight(is, new File(path), maxWidth, maxHeight);
	}
	public static void maxWidthHeight(File from, File to, int maxWidth, int maxHeight) throws Exception{
		BufferedImage image = ImageIO.read(from);
		if(image==null)return;
		Integer width = image.getWidth();
		Integer height = image.getHeight();
		if(width>maxWidth || height>maxHeight){
			ResampleOp resampleOp = new ResampleOp(DimensionConstrain.createMaxDimension(maxWidth, maxHeight));
			BufferedImage rescaled = resampleOp.filter(image, null);
			ImageIO.write(rescaled, "png", to);
		}
	}
	public static void maxWidthHeight(File from, String path, int maxWidth, int maxHeight) throws Exception{
		maxWidthHeight(from, new File(path), maxWidth, maxHeight);
	}
	public static void copyInputStreamToFile(InputStream inputStream, File file) throws Exception {
		if(inputStream!=null && file!=null){
			if(!file.exists()){
				file.mkdirs();
				file.delete();
				file.createNewFile();
			}
			FileOutputStream out = new FileOutputStream(file);
			byte[] bytes = new byte[1024];
			while(inputStream.read(bytes)!=-1){
				out.write(bytes);
			}
			out.flush();
			out.close();
			inputStream.close();
			
			String path = file.getPath();
			String maxPath = path.substring(0, path.lastIndexOf('.'))+"_max.png";
			maxWidthHeight(file, maxPath, 1024, 768);
			String midPath = path.substring(0, path.lastIndexOf('.'))+"_mid.png";
			maxWidthHeight(file, midPath, 310, 310);
			String minPath = path.substring(0, path.lastIndexOf('.'))+"_min.png";
			maxWidthHeight(file, minPath, 80, 80);
		}
	}

	public static final Random R = new Random();
	/**
	 * 产生（日期+100以内随机数+后缀名）的字符串；yyyy-MM-dd-HH-mm-ss-ms-random.ext
	 * @param inputStream 
	 * @param ext 
	 * @return
	 * @throws IOException 
	 */
	public static String createFileName(InputStream inputStream) throws IOException {
		MessageDigest digest = null;
		try {
			digest = MessageDigest.getInstance("MD5");
			byte[] buffer = new byte[1024];
			int len;
			while ((len = inputStream.read(buffer, 0, buffer.length)) != -1) {
				digest.update(buffer, 0, len);
			}
			inputStream.close();
		} catch (Exception e) {
			if(inputStream != null)inputStream.close();
			e.printStackTrace();
		}
		BigInteger bigInt = new BigInteger(1, digest.digest());
		return bigInt.toString(16);
	}
	public static byte[] imageToByteArray(File file) throws IOException {
		String fileName = file.getName();
		String ext = fileName.substring(fileName.lastIndexOf('.')+1, fileName.length());
		BufferedImage bi = ImageIO.read(file);
		if(bi==null)return null;
		ByteArrayOutputStream imageStream = new ByteArrayOutputStream();
		boolean resultWrite = ImageIO.write(bi, ext, imageStream);
		if(resultWrite){
			imageStream.flush();
			byte[] tagInfo = imageStream.toByteArray();
			return tagInfo;
		}
		return null;
	}
	
	/**
	 * 限制最大宽高缩放并压缩图片,如果不超出则直接复制到到
	 * @author  lfq
	 * @param is
	 * @param to
	 * @param maxWidth
	 * @param maxHeight
	 * @throws Exception
	 */
	public static void maxWidthHeight2(InputStream is, File to, int maxWidth, int maxHeight) throws Exception{
		BufferedImage image = ImageIO.read(is);
		if(image==null)return;
		Integer width = image.getWidth();
		Integer height = image.getHeight();
		if(width>maxWidth || height>maxHeight){
			ResampleOp resampleOp = new ResampleOp(DimensionConstrain.createMaxDimension(maxWidth, maxHeight));
			BufferedImage rescaled = resampleOp.filter(image, null);
			ImageIO.write(rescaled, "png", to);
		}else{
			ImageIO.write(image, "png", to);
		}
	}
	
	
	/**
	 * 图片缩放和截取处理
	 * 
	 * @author lfq
	 * @time 2014-11-17 上午10:52:58
	 * @param is
	 *            原图片输入流
	 * @param ouptPath
	 *            输出路径
	 * @param originalPath
	 *            原图输出路径(为空则不保存原图)
	 * @param width
	 *            宽度,如果是等比例缩放该参数代表最大宽度,否则表示压缩的宽度
	 * @param height
	 *            高度,如果是等比例缩放该参数代表最大高度,否则表示压缩的高度
	 * @param scale
	 *            是否等比例缩放,如果该值为false并且原图小于with或height时图片将会被放大
	 * @throws IOException
	 */
	public static void imageZip(InputStream is, String ouptPath, String originalPath,int width, int height, boolean scale) throws IOException {
		FileUtil.copyFile(is, new File(ouptPath));
		if(originalPath != null && !originalPath.trim().isEmpty() ){
            imageZip(ouptPath, originalPath, 1024, 768, true);//保存压缩后的原图（目前只为补充缩略图截图后功能缺失用）
		}
		imageZip(ouptPath, ouptPath, width, height, scale);
	}
	/**
	 * 图片缩放和截取处理
	 * 
	 * @author lfq
	 * @time 2014-11-17 上午10:52:58
	 * @param inputPath
	 *            原图片路径
	 * @param ouptPath
	 *            输出路径
	 * @param width
	 *            宽度,如果是等比例缩放该参数代表最大宽度,否则表示压缩的宽度
	 * @param height
	 *            高度,如果是等比例缩放该参数代表最大高度,否则表示压缩的高度
	 * @param scale
	 *            是否等比例缩放,如果该值为false并且原图小于with或height时图片将会被放大
	 * @throws IOException
	 */
	public static void imageZip(String inputPath, String ouptPath,int width, int height, boolean scale) throws IOException {
		File oldFile=new File(inputPath);
		// 获得源文件
		BufferedImage oldImg = ImageIO.read(oldFile);
		int oldWidth=oldImg.getWidth();
		int oldHeight=oldImg.getHeight();
		boolean com=false;//标识原图是否大于要压缩的尺寸
		if (oldWidth>width || oldHeight>height) {
			com=true;
		}
		
		if (com) {//原图大于要压缩的尺寸
			if (scale) {//等比例压缩
				int newWidth;
				int newHeight;
				// 为等比缩放计算输出的图片宽度及高度
				double rate1 = ((double) oldWidth)/width;// + 0.1;
				double rate2 = ((double) oldHeight)/height;// + 0.1;
				// 根据缩放比率大的进行缩放控制
				double rate = rate1 > rate2 ? rate1 : rate2;
				newWidth = (int) (oldWidth/ rate);
				newHeight = (int) (oldHeight / rate);
				
				BufferedImage newImg = new BufferedImage(newWidth,newHeight, BufferedImage.TYPE_INT_RGB);
				//Image.SCALE_SMOOTH 的缩略算法 生成缩略图片的平滑度的 优先级比速度高 生成的图片质量比较好 但速度慢
				newImg.getGraphics().drawImage(oldImg.getScaledInstance(newWidth, newHeight,Image.SCALE_SMOOTH), 0, 0, null);
				FileOutputStream out = new FileOutputStream(ouptPath);
				// JPEGImageEncoder可适用于其他图片类型的转换
				JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
				encoder.encode(newImg);
				out.close();
				
				System.out.println("原图大于要压缩的尺寸等比例压缩");
			}else{//非等比例压缩 
				int newWidth;
				int newHeight;
				// 为等比缩放计算输出的图片宽度及高度
				double rate1 = ((double) oldWidth)/width;//+ 0.1;
				double rate2 = ((double) oldHeight)/height;// + 0.1;
				// 根据缩放比率大的进行缩放控制
				double rate = rate1 > rate2 ? rate1 : rate2;
				while (true) {//确定压缩的图片要大于截图的图
					newWidth = (int) (oldWidth/ rate);
					newHeight = (int) (oldHeight / rate);
					if (newWidth>=width && newHeight>=height) {
						break;
					}
					rate=rate-0.01;
				}
				
				//1.先压缩
				BufferedImage newImg = new BufferedImage(newWidth,newHeight, BufferedImage.TYPE_INT_RGB);
				//Image.SCALE_SMOOTH 的缩略算法 生成缩略图片的平滑度的 优先级比速度高 生成的图片质量比较好 但速度慢
				newImg.getGraphics().drawImage(oldImg.getScaledInstance(newWidth, newHeight,Image.SCALE_SMOOTH), 0, 0, null);
				
				//2.再截图
				BufferedImage newImg2 = new BufferedImage(width,height, BufferedImage.TYPE_INT_RGB);
				newImg2.getGraphics().drawImage(newImg, 0, 0, null);
				
				//3.输出结果图片
				FileOutputStream out = new FileOutputStream(ouptPath);
				// JPEGImageEncoder可适用于其他图片类型的转换
				JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
				encoder.encode(newImg2);
				out.close();
				
				System.out.println("原图大于要压缩的尺寸非等比例压缩");
			}
		}else{//原图小于要压缩的尺寸
			if (scale) {//等比例压缩
				//直接显示原图
				if (oldFile.length()<1024*10) {//小于10kb的直接用原图
					if (!inputPath.equals(ouptPath)) {
						FileInputStream input=new FileInputStream(oldFile);
						FileOutputStream out = new FileOutputStream(ouptPath);
						byte[] buffer = new byte[255];
						int length = 0;
						while ((length = input.read(buffer)) > 0) {
							out.write(buffer, 0, length);
						}
						input.close();
						out.close();
					}
				}else{//否则使用工具类处理让图片变小但质量会有变化
					// JPEGImageEncoder可适用于其他图片类型的转换
					FileOutputStream out = new FileOutputStream(ouptPath);
					JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
					encoder.encode(oldImg);
					out.close();
				}
				
				System.out.println("原图小于要压缩的尺寸等比例压缩");
			}else{//非等比例压缩
				int newWidth;
				int newHeight;
				// 为等比缩放计算输出的图片宽度及高度
				double rate1 = ((double) oldWidth)/width;// + 0.1;
				double rate2 = ((double) oldHeight)/height;// + 0.1;
				// 根据缩放比率大的进行缩放控制
				double rate = rate1 > rate2 ? rate1 : rate2;
				
				do{//确定压缩的图片要大于截图的图
					newWidth = (int) (oldWidth/ rate);
					newHeight = (int) (oldHeight / rate);
					if (newWidth>=width && newHeight>=height) {
						break;
					}
					rate=rate-0.01;
				}while(true);
				
				//1.先放大
				BufferedImage newImg = new BufferedImage(newWidth,newHeight, BufferedImage.TYPE_INT_RGB);
				//Image.SCALE_SMOOTH 的缩略算法 生成缩略图片的平滑度的 优先级比速度高 生成的图片质量比较好 但速度慢
				newImg.getGraphics().drawImage(oldImg.getScaledInstance(newWidth, newHeight,Image.SCALE_SMOOTH), 0, 0, null);
				
				//2.再截图
				BufferedImage newImg2 = new BufferedImage(width,height, BufferedImage.TYPE_INT_RGB);
				newImg2.getGraphics().drawImage(newImg, 0, 0, null);
				
				//3.输出结果图片
				FileOutputStream out = new FileOutputStream(ouptPath);
				// JPEGImageEncoder可适用于其他图片类型的转换
				JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
				encoder.encode(newImg2);
				out.close();
				System.out.println("原图小于要压缩的尺寸非等比例压缩");
			}
		}
	}

	/**
	 * 按尺寸质量压缩（测试）
	 * @param is
	 * @param to
	 * @param quality
	 * @throws IOException
	 */
	public static void compressQuality(InputStream is, File to, float quality, int maxWidth, int maxHeight) throws IOException{
		//压缩大小
		BufferedImage image = ImageIO.read(is);
		if(image==null)return;
		Integer width = image.getWidth();
		Integer height = image.getHeight();
		if(width>maxWidth || height>maxHeight){
			ResampleOp resampleOp = new ResampleOp(DimensionConstrain.createMaxDimension(maxWidth, maxHeight));
			image = resampleOp.filter(image, null);
		}
		// 得到指定Format图片的writer 
		Iterator<ImageWriter> iter =  ImageIO.getImageWritersByFormatName("jpeg");
		ImageWriter imageWriter = iter.next();
		
		// 得到指定writer的输出参数设置(ImageWriteParam )  
        ImageWriteParam iwp = imageWriter.getDefaultWriteParam();  
        iwp.setCompressionMode(ImageWriteParam.MODE_EXPLICIT); // 设置可否压缩  
        iwp.setCompressionQuality(quality); // 设置压缩质量参数  
        iwp.setProgressiveMode(ImageWriteParam.MODE_DISABLED);
        
        ColorModel colorModel = ColorModel.getRGBdefault();  
        // 指定压缩时使用的色彩模式  
        iwp.setDestinationType(new javax.imageio.ImageTypeSpecifier(colorModel,  
                colorModel.createCompatibleSampleModel(16, 16)));
        
        // 开始打包图片，写入byte[]  
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream(); // 取得内存输出流  
        IIOImage iIamge = new IIOImage(image, null, null); 
        
        // 此处因为ImageWriter中用来接收write信息的output要求必须是ImageOutput  
        // 通过ImageIo中的静态方法，得到byteArrayOutputStream的ImageOutput  
        imageWriter.setOutput(ImageIO  
                .createImageOutputStream(byteArrayOutputStream));  
        imageWriter.write(null, iIamge, iwp); 
        
        InputStream sbs = new ByteArrayInputStream(byteArrayOutputStream.toByteArray());
        ImageIO.write(ImageIO.read(sbs), "png", to);
        
	}
}
