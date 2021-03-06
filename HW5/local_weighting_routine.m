 % Description: Function to manually filter the image using
 %              the given filters.
 % Author : Niyati Shah (nxs6032)

function output_image = local_weighting_routine( input_image, weights )
    
    wt_dims = size( weights ); % dimensions of the weights matrix, a MxM matrix.
    im_dims = size( input_image ); % dimensions of the image

    if length(im_dims) > 2 
       % It checks if the image is grey scale or colored
        input_image = rgb2gray( input_image );
    end


    output_image =(input_image); % Set the default return values �
   
   %Calculate normalization factor
    Norm_weight =0;
    for i = 1:size(weights,1)
        for j = 1:size(weights,2)
            if weights(i,j)>0
                Norm_weight = Norm_weight + abs(weights(i,j)); 
            end
        end
    end
     Norm_weight =   Norm_weight*(wt_dims(2)-1 ) ;   
   
   
    S = floor(wt_dims(1)/2);
    T = floor(wt_dims(2)/2);
    Q = ceil(wt_dims(1)/2);
    R = ceil(wt_dims(2)/2);
    for row = Q : (im_dims(1) - Q  - 1 )
         for col = R : (im_dims(2) - R - 1 )
            sum1 = 0;
                for ii = -S : S
                    for kk = -T : T
                         sum1 = sum1 + double(input_image( (row + ii) , (col + kk) )) * weights( S+ii+1, T+kk+1 );
                    end
                end
                output_image( row, col ) = (sum1/Norm_weight) ;
         end
    end
    
    
    %imagesc( output_image ); colormap( gray );
end