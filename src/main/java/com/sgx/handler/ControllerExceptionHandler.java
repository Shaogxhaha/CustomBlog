package com.sgx.handler;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;


/*拦截所有具有Controller注解*/
@ControllerAdvice
public class ControllerExceptionHandler {
    /*创建日志对象，获取日志信息*/
    private final Logger logger= LoggerFactory.getLogger(this.getClass());

    /*拦截所有异常类型*/
    @ExceptionHandler(Exception.class)
    public ModelAndView  exceptionHandler(HttpServletRequest request,Exception e) throws Exception {
        logger.error("Request URL : {} , Exception:{}",request.getRequestURL(),e);

        if(AnnotationUtils.findAnnotation(e.getClass(), ResponseStatus.class)!=null){
            throw e;
        }
        ModelAndView mv=new ModelAndView();

        mv.addObject("url",request.getRequestURL());
        mv.addObject("exception",e);
        mv.setViewName("error/error");
        return mv;
    }
}
