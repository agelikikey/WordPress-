<?php
namespace Rigo\Types;
    
use WPAS\Types\BasePostType;

class Phone extends BasePostType{
     public static function serialize($object){
        
        $arrayObject = (array) $object;
        $arrayObject['make'] = get_field( 'make', $object->ID );
        $arrayObject['model'] = get_field( 'model', $object->ID );
        $arrayObject['year'] = get_field( 'year', $object->ID );
        $arrayObject['color'] = get_field( 'color', $object->ID );
        return $arrayObject;
        
    }
}

?>