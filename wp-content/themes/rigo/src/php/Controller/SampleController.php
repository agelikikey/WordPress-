<?php
namespace Rigo\Controller;

use Rigo\Types\Course;
use Rigo\Types\Phone;

class SampleController{
    
    public function getHomeData(){
        return [
            'name' => 'Rigoberto'
        ];
    }
    
    public function getDraftCourses(){
        $query = Course::all([ 'status' => 'draft' ]);
        return $query->posts;
    }

     public function getDraftPhones(){
        $query = Phone::all([ 'status' => 'draft' ]);
        $lst = [];
        forEach($query->posts as $phone) {
            $lst[] = Phone::serialize($phone);
        }
        return $lst;
    }
    
}
?>