package org.example;

import java.io.FilterOutputStream;
import java.util.Arrays;

public class ArrayExercise {
    public static void main(String[] args) {
        int [] orgArr={1,2,-1,-8,-1, 2};
        System.out.println(Arrays.toString(orgArr));

        String negNumbers="";
        for (int i=0;i<orgArr.length;i++){
            if (orgArr[i]<0){
                negNumbers +=orgArr[i];
                orgArr[i] =Integer.parseInt(String.valueOf(orgArr[i]).substring(1));
            }
        }

        String negStr="";
        for (int i=1;i<negNumbers.length();i=i+2){
            negStr=negStr + negNumbers.charAt(i);
        }

        Arrays.sort(orgArr);
        for (int i=0;i<negStr.length();i++){
            for (int j=orgArr.length-1;j>=0;j--){
                if (orgArr[j]==Integer.parseInt(String.valueOf(negStr.charAt(i)))){
                    orgArr[j] =Integer.parseInt(String.valueOf("-"+negStr.charAt(i)));
                    break;
                }
            }
            int lastIndex = negStr.lastIndexOf((negStr.charAt(i)));
        }

        System.out.println(Arrays.toString(orgArr));
    }
}
