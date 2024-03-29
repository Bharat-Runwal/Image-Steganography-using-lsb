function [O]= encode_msg(inp,message,c_bit);
inp(size(inp,1),size(inp,2),1)=length(message);
inp(size(inp,1),size(inp,2),2)=c_bit;
%the output pixel is assigned the value of the pixel that the point falls within. No other pixels are considered.
inp=imresize(inp,[size(inp,1) size(inp,2)],'nearest');            
length_msg=length(message)*8;     
ascii=uint8(message);     
bin_str=transpose(dec2bin(ascii,8));    
bin_str= bin_str(:);    
N = length(bin_str);    
char_arr=zeros(N,1);    
for k=1:N   
    if(bin_str(k)=='1')    
         char_arr(k)=1;   
    else    
         char_arr(k)=0;    
    end    
end   
out=inp;   
height=size(inp,1);   
width=size(inp,2);    
count=1;   
for i=1:height    
     for j=1:width    
          lsb=mod(double(inp(i,j,c_bit)), 2);    
           if (count>length_msg ||lsb==char_arr(count))       
             out(i,j) = inp(i,j);      
           elseif(lsb==1)      
            out(i,j,c_bit) = (inp(i,j,c_bit)-1);     
           elseif(lsb==0)
            out(i,j,c_bit)=(inp(i,j,c_bit) + 1);     
           end
     count=count+1;
     end    
 end                       
                           
O=out;       

end