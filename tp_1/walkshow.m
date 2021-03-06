function walkshow(states,name)
temp_size=size(states);
n = temp_size(1,1);
im = {imread('step1.png'),
    imread('step2.png'),
    imread('step3.png'),
    imread('step4.png'),
    imread('step5.png'),
    imread('step6.png'),
    imread('step7.png'),
    imread('step8.png'),
    imread('step9.png'),
    imread('step10.png'),
    imread('step11.png'),
    imread('step12.png'),
    imread('step13.png'),
    imread('step14.png'),
    imread('step15.png'),
    imread('step16.png')};



p = im{states(1)};
for i = 2:n
    p = [p, im{states(i)}];
end

imwrite(p, name);
imshow(p);
end
